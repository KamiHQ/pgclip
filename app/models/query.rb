class Query < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_paper_trail

  def last_result(params = nil)
    r = results.order("created_at DESC")
    if params
      r = r.where("parameters = ARRAY[?]", params)
    else
      r = r.where("parameters IS NULL")
    end
    r.first
  end

  def last_queried_at(params = nil)
    last_result(params).andand.created_at
  end

  def latest_result_age(params = nil)
    last_queried_at(params).present? ? (Time.now - last_queried_at(params)) : Float::INFINITY
  end

  def fresh?(params = nil)
    latest_result_age(params) < ttl_minutes.minutes
  end

  def current?(params = nil)
    last_queried_at(params).andand > updated_at
  end

  def has_results?(params = nil)
    last_result(params).present?
  end
end
