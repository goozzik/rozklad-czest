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
          AND work = ?",
        lines_id,
        station_from_id,
        Time.now.advance(:hours => 1),
        Time.now.at_beginning_of_day.wday == 0,
        Time.now.at_beginning_of_day.wday == 6,
        (Time.now.at_beginning_of_day.wday != 6 and Time.now.at_beginning_of_day.wday != 0)
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
          AND work = ?",
        lines_id,
        station_from_id,
        Time.now.tomorrow.advance(:hours => 1),
        Time.now.tomorrow.at_beginning_of_day.wday == 0,
        Time.now.tomorrow.at_beginning_of_day.wday == 6,
        (Time.now.tomorrow.at_beginning_of_day.wday != 6 and Time.now.tomorrow.at_beginning_of_day.wday != 0)
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

end
