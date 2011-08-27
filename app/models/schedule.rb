class Schedule < ActiveRecord::Base

  GET_LIMIT = 10
  TODAY_LIMIT = GET_LIMIT

  belongs_to :line
  belongs_to :station

  def self.today(lines_id, station_from_id)
    find(:all,
      :conditions => [
        "line_id IN (?)
          AND station_id = ?
          AND arrival_at > ?
          AND ((sunday = 't' AND saturday = 't' AND work = 't' AND holiday = 't')
          OR (sunday = ? AND saturday = ? AND work = ? AND holiday = ?)
          OR (sunday = ? AND saturday = ? AND work = 'f' AND holiday = 'f'))",
        lines_id,
        station_from_id,
        Time.now,
        Time.now.at_beginning_of_day.wday == 0,
        Time.now.at_beginning_of_day.wday == 6,
        (!night_weekend? && !holiday?),
        holiday?,
        night_weekend?,
        night_weekend?
      ],
      :order => 'arrival_at',
      :limit => TODAY_LIMIT
    )
  end

  def self.tomorrow(lines_id, station_from_id, limit)
    find(:all,
      :conditions => [
        "line_id IN (?)
          AND station_id = ?
          AND arrival_at > ?
          AND ((sunday = 't' AND saturday = 't' AND work = 't' AND holiday = 't')
          OR (sunday = ? AND saturday = ? AND work = ? AND holiday = ?)
          OR (sunday = ? AND saturday = ? AND work = 'f' AND holiday = 'f'))",
        lines_id,
        station_from_id,
        Time.now.tomorrow.at_beginning_of_day,
        Time.now.tomorrow.at_beginning_of_day.wday == 0,
        Time.now.tomorrow.at_beginning_of_day.wday == 6,
        (!tomorrow_night_weekend? && !tomorrow_holiday?),
        tomorrow_holiday?,
        tomorrow_night_weekend?,
        tomorrow_night_weekend?
    ],
      :order => 'arrival_at',
      :limit => limit
    )
  end

  def self.get(station_from_id, station_to_id)
    lines_id = Line.ids_by_stations(station_from_id, station_to_id)
    today_schedules = Schedule.today(lines_id, station_from_id)
    left = GET_LIMIT - today_schedules.count
    if left > 0
      tomorrow_schedules = Schedule.tomorrow(lines_id, station_from_id, left)
      schedules = today_schedules + tomorrow_schedules
    else
      schedules = today_schedules
    end
    { :schedules => schedules, :station_to => Station.find(station_to_id) }
  end

  def self.get_by_near_stations_and_station_to(within, location, station_to_id)
    schedules = []
    Station.within(Station.to_f(within), :origin => location).order('distance asc').each { |station| schedules << get(station.id, station_to_id) if Line.find_first_by_stations(station.id, station_to_id) }
    schedules
  end

  def self.get_by_station_from_and_location(station_from_id, location)
    schedules = []
    Station.within(0.5, :origin => Schedule.location_to_latlng(location)).order('distance asc').each do |station|
      schedules << Schedule.get(station_from_id, station.id) if Line.find_first_by_stations(station_from_id, station.id)
    end
    schedules
  end

  def self.get_by_near_stations_and_location(within, my_location, location)
    schedules = []
    stations_near = Station.within(Station.to_f(within), :origin => my_location).order('distance asc')
    stations_to = Station.within(0.5, :origin => Schedule.location_to_latlng(location)).order('distance asc')
    stations_near.each do |station_from|
      stations_to.each do |station_to|
        schedules << Schedule.get(station_from.id, station_to.id) if Line.find_first_by_stations(station_from.id, station_to.id)
      end
    end
    schedules
  end

  def self.location_to_latlng(location)
    location = location.to_ascii
    if location =~ /,/
      location_geocoded = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    else
      location = "Czestochowa, " + location
      location_geocoded = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    end
    [location_geocoded.lat, location_geocoded.lng]
  end
      

  def self.paginate_by_hour(line_id, station_id, time_type)
    paginated_schedules = []
    _schedules = []
    schedules = Schedule.where(:line_id => line_id, :station_id => station_id, time_type => true).select(:arrival_at).collect(&:arrival_at)
    unless schedules.empty?
      last_hour = schedules.first.hour
      schedules.each do |schedule|
        if schedule.hour != last_hour
          last_hour = schedule.hour
          paginated_schedules << _schedules
          _schedules = []
        end
        _schedules << schedule
      end
      paginated_schedules << _schedules
    end
    paginated_schedules
  end

  def self.holiday?
    holiday_months = Time.now.month == 7 || Time.now.month == 8
    working_days = Time.now.at_beginning_of_day.wday != 6 && Time.now.at_beginning_of_day.wday != 0
    @holiday ||= holiday_months && working_days
  end

  def self.tomorrow_holiday?
    holiday_months = Time.now.tomorrow.month == 7 || Time.now.tomorrow.month == 8
    working_days = Time.now.tomorrow.at_beginning_of_day.wday != 6 && Time.now.tomorrow.at_beginning_of_day.wday != 0
    @tomorrow_holiday ||= holiday_months && working_days
  end

  def self.night_weekend?
    @night_weekend ||= Time.now.at_beginning_of_day.wday == 0 || Time.now.at_beginning_of_day.wday == 6
  end

  def self.tomorrow_night_weekend?
    @tomorrow_night_weekend ||= Time.now.tomorrow.at_beginning_of_day.wday == 0 || Time.now.tomorrow.at_beginning_of_day.wday == 6
  end

end
