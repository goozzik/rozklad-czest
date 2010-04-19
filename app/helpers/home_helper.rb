module HomeHelper
  def time_to_seconds
    return (Time.now.hour * 3600) + (Time.now.min * 60) + (Time.now.sec)
  end
# liczy sekundy pozostałe do przyjazdu autobusa i zamienia je na minuty, sekundy
  def countdown_schedule(to)
    time = ((to.arrival_at.hour * 3600) + (to.arrival_at.min * 60) + (to.arrival_at.sec)) - time_to_seconds
    minutes = time / 60
    seconds = time % 60
    return "#{minutes}:#{seconds}"  
  end
end
  