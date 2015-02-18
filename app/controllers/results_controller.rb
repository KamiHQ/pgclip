require 'psych'

class ResultsController < ApplicationController
  before_action :set_query, only: [:show]

  def show
    query_parameters = params[:params]
    p query_parameters
    unless @query.fresh?(query_parameters) && @query.current?(query_parameters)
      p "Refreshing"
      RefreshQueryJob.new.async.perform(@query.id, query_parameters) 
    else
      p "Not Refreshing"
    end

    unless @query.has_results?(query_parameters) && @query.current?(query_parameters)
      render json: {"error" => "Data not ready yet"}, status: 503 # We don't have results yet, tell the client to come back later.
      return
    end

    @result = @query.last_result(query_parameters)
    unless @result.error
      query_result = Psych.safe_load(@result.result, [Symbol])

      @fields = query_result[:fields]
      @values = query_result[:values]
    end
    render :layout => false
  end

  private
    def set_query
      @query = Query.find(params[:id])
    end
end
