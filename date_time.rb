require 'date'
module DateAndTimes

    def self.get_date(date_string)
        begin
            date = Date.parse(date_string).to_s
        rescue
            puts Rainbow("Please enter a valid date.").indianred
            retry
        end
        return date
    end

    def self.get_time(time_string)
        begin
            time_p = DateTime.strptime("#{time_string}", '%I:%M %p')
            time = time_p.strftime('%I:%M %p')
        rescue
            puts Rainbow("Please enter a valid time").indianred
            retry
        end
        return time
    end

    def self.today
        today = Time.now.strftime("%d %m %y")
        today_date = Date.parse(today).to_s
        return today_date
    end
end