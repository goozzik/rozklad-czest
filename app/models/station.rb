class Station < ActiveRecord::Base

  has_many :schedules
  acts_as_mappable

  validates_uniqueness_of :name, :case_sensitive => false

  validate :validate_uniqueness_of_lat_lng_pair

  def self.paginate_by_letter
    ordered_stations = []
    get_ordered_letters.each do |letter|
      stations = where('name LIKE ?', "#{letter}%")
      ordered_stations << stations
    end
    return ordered_stations
  end

  def self.get_ordered_letters
    letters = []
    all.each { |station| letters << station.name.first if letters.last != station.name.first }
    return letters
  end

  private

    def validate_uniqueness_of_lat_lng_pair
      errors.add :lat, 'non unique lat-lng pair' if has_existing_lat_lng_pair?
    end

    def has_existing_lat_lng_pair?
      self.class.find_by_lat_and_lng(lat, lng).try(:present?)
    end

end
