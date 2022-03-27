require 'date'
module DateAndTimes

    def self.get_date(ask_date)
        return Date.parse(ask_date).to_s
    end

    def self.get_time(ask_time)
        time_p = DateTime.strptime("#{ask_time}", '%H:%M')
        time = time_p.strftime('%H:%M')
        return time
    end

    def self.today
        today = Time.now.strftime("%d %m %y")
        today_date = Date.parse(today).to_s
        return today_date
    end
end