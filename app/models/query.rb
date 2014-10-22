class Query < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_paper_trail
  
  def last_result
    results.order("created_at DESC").first
  end
end
