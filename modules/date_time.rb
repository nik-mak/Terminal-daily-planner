require 'date'

# Used to find the dates and times in the right format
module DateAndTimes
  def self.get_date(date)
    Date.parse(date).to_s
  end

  def self.get_time(time)
    time_p = DateTime.strptime(time.to_s, '%H:%M')
    time_p.strftime('%H:%M')
  end

  def self.today
    today = Time.now.strftime('%d %m %y')
    Date.parse(today).to_s
  end
end
