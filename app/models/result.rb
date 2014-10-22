class Result < ActiveRecord::Base
  belongs_to :query
  validates_presence_of :query
end
