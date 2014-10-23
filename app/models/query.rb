class Query < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_paper_trail

  def last_result
    results.order("created_at DESC").first
  end

  def last_queried_at
    last_result.andand.created_at
  end

  def latest_result_age
    last_queried_at.present? ? (Time.now - last_queried_at) : Float::INFINITY
  end

  def fresh?
    latest_result_age < ttl_minutes.minutes
  end

  def current?
    last_queried_at.andand > updated_at
  end

  def has_results?
    last_result.present?
  end
end
