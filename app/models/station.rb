class Station < ActiveRecord::Base

  has_many :schedules
  acts_as_mappable

  validates_uniqueness_of :name, :case_sensitive => false

  validate :validate_uniqueness_of_lat_lng_pair

  def self.get_id_by_name_if_exist(name)
    station = find_by_name(name)
    station.id if station
  end

  private

    def validate_uniqueness_of_lat_lng_pair
      errors.add :lat, 'non unique lat-lng pair' if has_existing_lat_lng_pair?
    end

    def has_existing_lat_lng_pair?
      self.class.find_by_lat_and_lng(lat, lng).try(:present?)
    end

end
