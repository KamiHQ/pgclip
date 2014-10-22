require 'psych'

class ResultsController < ApplicationController
  def show
    @query = Query.find(params[:id])
    result = @query.last_result
    unless result
      render nothing:true, status: 500
      return
    end

    query_result = Psych.safe_load(result.result, [Symbol])

    @query_time = result.created_at
    @fields = query_result[:fields]
    @values = query_result[:values]
  end
end
