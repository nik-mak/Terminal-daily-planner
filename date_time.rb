require 'date'
module DateAndTimes

    def self.get_date(date_string)
        date = Date.parse(date_string).to_s
    end

    def self.get_time(time_string)
        time_p = DateTime.strptime("#{time_string}", '%k:%M')
        time = time_p.strftime('%k:%M')
        return time
    end

    def self.today
        today = Time.now.strftime("%d %m %y")
        today_date = Date.parse(today).to_s
        return today_date
    end
end