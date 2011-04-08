# coding: utf-8
class Favourite < ActiveRecord::Base
  
  belongs_to :user
  before_validation :upcase_stations
  validate :validate_station_from_exist,
           :validate_station_to_exist,
           :validate_line_exist

  private

    def upcase_stations
      self.station_from = station_from.upcase
      self.station_to = station_to.upcase
    end

    def validate_station_from_exist
      errors.add :station_from, 'Przystanek odjazdowy nie istnieje.' unless station_from_object
    end

    def validate_station_to_exist
      errors.add :station_to, 'Przystanek docelowy nie istnieje.' unless station_to_object
    end

    def validate_line_exist
      if station_from_object and station_to_object
        errors.add :station_from, 'Brak połączeń.' unless Line.find_first_by_stations([station_from_object.id, station_to_object.id])
      end
    end

    def station_from_object
      @station_from_object ||= Station.find_by_name(station_from)
    end

    def station_to_object
      @station_to_object ||= Station.find_by_name(station_to)
    end

end
