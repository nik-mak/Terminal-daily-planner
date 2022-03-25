require 'csv'
require 'tty-prompt'
require 'rainbow'

prompt = TTY::Prompt.new

def help
    return "Hachi is your daily planner right here in your terminal! You can navigate through the options with the arrow keys.

    Add:      allows you to add an event you just need to specify what day, what time, and give it a name.
    Delete:   allows you to delete an event.
    View:     allows you to view the events of a specific day! you only need to specify the date.
    Help:     will show you how to use this app.
    Exit:     will close the planner.
    
    Date can be entered as dd/mm/yyyy or just the days number and the month and year will default to the current month and year.
    All times must be enter in hh:mm am/pm format.
    "
end

module GetDateTime
    def self.get_date
        prompt = TTY::Prompt.new
        begin
            date_string = prompt.ask("Please enter a day [dd/mm/yyyy]", required: true)
            date = Date.parse(date_string).to_s
        rescue
            puts Rainbow("Please enter a valid date.").indianred
            retry
        end
        return date
    end

    def self.get_time
        prompt = TTY::Prompt.new
        begin
            time_string = prompt.ask("Please enter a time? [hh:mm am/pm]", required: true)
            time_p = DateTime.strptime("#{time_string}", '%I:%M %p')
            time = time_p.strftime('%I:%M %p')
        rescue
            puts Rainbow("Please enter a valid time").indianred
            retry
        end
    end

    def self.today
        today = Time.now.strftime("%d %m %y")
        today_date = Date.parse(today).to_s
        return today_date
    end
end

module EventInfo
    def self.event_array(date)
        array = []
        csv = CSV.open('dates.csv', 'r', headers: true)
        csv.select do |row|
            if row['Date'] == date
                array << row.to_h
            end
        end
        return array
    end

    def self.no_of_events(array)
        return "You have #{array.length} events!"
    end

    def self.list_events(array)
        array.each do |hash|
            puts Rainbow("You have #{hash["Details"]} at #{hash["Time"]}").burlywood
        end
    end
end

ARGV.each do |arg|
	if arg == "-h" || arg == "--help"
		puts help
		return
	end
end

system("clear")
puts Rainbow("Hachi v1.0").goldenrod
puts Rainbow("Today is #{Time.now.strftime("%A, %d of %B")}").goldenrod
# puts affirmation here

date = GetDateTime.today
array = EventInfo.event_array(date)
puts Rainbow(EventInfo.no_of_events(array)).burlywood
EventInfo.list_events(array)

while true
    option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w(Add Delete View Help Exit), show_help: :always, active_color: :yellow)

    case option
    when 'Add'
        system("clear") 
        date = GetDateTime.get_date
        time = GetDateTime.get_time
        details = prompt.ask("What would you like to call this event?")
    
        puts "Are these the correct details?"
        confirm = prompt.yes?("Date: #{date}, Time: #{time}, Details: #{details}")
        if confirm == 'yes'
            csvfile = CSV.open('dates.csv', 'a')
            csvfile << [date, time, details]
            csvfile.close
        end
    when 'Delete'

    when 'View'
        system('clear')
        date = GetDateTime.get_date
        array = EventInfo.event_array(date)
        puts EventInfo.no_of_events(array)
        EventInfo.list_events(array)
    when 'Help'
        system('clear')
        puts help
    when 'Exit'
        system('clear')
        return
    end
end

