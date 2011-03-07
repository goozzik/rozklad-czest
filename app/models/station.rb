class Station < ActiveRecord::Base
  has_many :schedules
  acts_as_mappable
end
