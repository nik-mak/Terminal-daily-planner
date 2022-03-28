# frozen_string_literal: true

require 'date'

# Used to find the dates and times in the right format
module DateAndTimes
  def self.get_date(ask_date)
    Date.parse(ask_date).to_s
  end

  def self.get_time(ask_time)
    time_p = DateTime.strptime(ask_time.to_s, '%H:%M')
    time_p.strftime('%H:%M')
  end

  def self.today
    today = Time.now.strftime('%d %m %y')
    Date.parse(today).to_s
  end
end
