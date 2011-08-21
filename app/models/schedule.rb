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
          AND sunday = ?
          AND saturday = ?
          AND work = ?
          AND holiday = ?",
        lines_id,
        station_from_id,
        Time.now,
        Time.now.at_beginning_of_day.wday == 0,
        Time.now.at_beginning_of_day.wday == 6,
        ((Time.now.at_beginning_of_day.wday != 6 && Time.now.at_beginning_of_day.wday != 0) && !holiday?),
       holiday?
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
          AND sunday = ?
          AND saturday = ?
          AND work = ?
          AND holiday = ?",
        lines_id,
        station_from_id,
        Time.now.tomorrow.at_beginning_of_day,
        Time.now.tomorrow.at_beginning_of_day.wday == 0,
        Time.now.tomorrow.at_beginning_of_day.wday == 6,
        ((Time.now.tomorrow.at_beginning_of_day.wday != 6 && Time.now.tomorrow.at_beginning_of_day.wday != 0) && !tomorrow_holiday?),
        tomorrow_holiday?
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
    location = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    Station.within(0.5, :origin => [location.lat, location.lng]).order('distance asc').each do |station|
      schedules << Schedule.get(station_from_id, station.id) if Line.find_first_by_stations(station_from_id, station.id)
    end
    schedules
  end

  def self.get_by_near_stations_and_location(within, my_location, location)
    schedules = []
    location = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    stations_near = Station.within(Station.to_f(within), :origin => my_location).order('distance asc')
    stations_to = Station.within(0.5, :origin => [location.lat, location.lng]).order('distance asc')
    stations_near.each do |station_from|
      stations_to.each do |station_to|
        schedules << Schedule.get(station_from.id, station_to.id) if Line.find_first_by_stations(station_from.id, station_to.id)
      end
    end
    schedules
  end

  def self.paginate_by_hour(line_id, station_id, time_type)
    paginated_schedules = []
    _schedules = []
    schedules = Schedule.where(:line_id => line_id, :station_id => station_id, time_type => true)
    unless schedules.empty?
      last_hour = schedules.first.arrival_at.hour
      schedules.each do |schedule|
        if schedule.arrival_at.hour != last_hour
          last_hour = schedule.arrival_at.hour
          paginated_schedules << _schedules
          _schedules = []
        end
        _schedules << schedule
      end
      paginated_schedules << _schedules
    end
  end

  def self.holiday?
    holiday_months = Time.now.month == 7 || Time.now.month == 8
    working_days = Time.now.at_beginning_of_day.wday == 1 || Time.now.at_beginning_of_day.wday == 2 || Time.now.at_beginning_of_day.wday == 3 || Time.now.at_beginning_of_day.wday == 4 || Time.now.at_beginning_of_day.wday == 5
    holiday_months && working_days
  end

  def self.tomorrow_holiday?
    holiday_months = Time.now.tomorrow.month == 7 || Time.now.tomorrow.month == 8
    working_days = Time.now.tomorrow.at_beginning_of_day.wday == 1 || Time.now.tomorrow.at_beginning_of_day.wday == 2 || Time.now.tomorrow.at_beginning_of_day.wday == 3 || Time.now.tomorrow.at_beginning_of_day.wday == 4 || Time.now.tomorrow.at_beginning_of_day.wday == 5
    holiday_months && working_days
  end

end
