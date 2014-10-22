class Query < ActiveRecord::Base
  has_many :results

  def last_result
    results.order("created_at DESC").first
  end
end
