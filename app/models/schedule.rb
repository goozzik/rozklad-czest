class Schedule < ActiveRecord::Base

  GET_LIMIT = 10
  TODAY_LIMIT = GET_LIMIT

  belongs_to :line
  belongs_to :station

  HOLIDAY_CHECK = ((Time.now.month == 7 or Time.now.month == 8) and (Time.now.at_beginning_of_day.wday == 1 or Time.now.at_beginning_of_day.wday == 2 or Time.now.at_beginning_of_day.wday == 3 or Time.now.at_beginning_of_day.wday == 4 or Time.now.at_beginning_of_day.wday == 5))

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
        ((Time.now.at_beginning_of_day.wday != 6 and Time.now.at_beginning_of_day.wday != 0) and not HOLIDAY_CHECK),
        HOLIDAY_CHECK
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
        ((Time.now.tomorrow.at_beginning_of_day.wday != 6 and Time.now.tomorrow.at_beginning_of_day.wday != 0) and not HOLIDAY_CHECK),
        HOLIDAY_CHECK
    ],
      :order => 'arrival_at',
      :limit => limit
    )
  end

  def self.get(station_from_id, station_to_id)
    lines_id = Line.ids_by_stations(station_from_id, station_to_id)
    return [] if lines_id.empty?
    today_schedules = Schedule.today(lines_id, station_from_id)
    left = GET_LIMIT - today_schedules.count
    if left > 0
      next_day_schedules = Schedule.tomorrow(lines_id, station_from_id, left)
      today_schedules + next_day_schedules
    else
      today_schedules
    end
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

end
