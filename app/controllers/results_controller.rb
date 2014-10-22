require 'psych'

class ResultsController < ApplicationController
  def show
    @query = Query.find(params[:id])

    last_queried_at = @query.last_result.andand.created_at
    unless (last_queried_at.andand > @query.ttl_minutes.minutes.ago) && (last_queried_at.andand > @query.updated_at)
      p "Refreshing"
      RefreshQueryJob.new.async.perform(@query.id) 
    else
      p "Not Refreshing, #{last_queried_at.andand} , #{@query.ttl_minutes.minutes.ago}"
    end

    result = @query.last_result
    unless result
      render nothing:true, status: 500
      return
    end

    query_result = Psych.safe_load(result.result, [Symbol])

    @result = result
    @fields = query_result[:fields]
    @values = query_result[:values]
  end
end
