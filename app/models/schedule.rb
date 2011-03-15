class Schedule < ActiveRecord::Base

  TODAY_LIMIT = 10

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

end
