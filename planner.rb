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
    
    All dates must be enter in dd/mm/yyyy format.
    All times must be enter in hh:mm am/pm format."
end

module GetDateTime
    def self.get_date
        prompt = TTY::Prompt.new
        begin
            date_string = prompt.ask("Please enter a day [dd/mm/yyyy]", required: true)
            date = Date.parse(date_string).to_s
        rescue
            puts "Please enter a valid date."
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
            puts "Please enter a valid time"
            retry
        end
    end

    def self.today
        today = Time.now.strftime("%d %m %y")
        today_date = Date.parse(today).to_s
        return today_date
    end

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
            puts "You have #{hash["Details"]} at #{hash["Time"]}"
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
puts "Hachi v1.0"
puts "Today is #{Time.now.strftime("%A, %d of %B")}" 
# puts affirmation here

date = GetDateTime.today
array = GetDateTime.event_array(date)
puts GetDateTime.no_of_events(array)
GetDateTime.list_events(array)

while true
    option = prompt.select('What would you like to do?', %w(Add Delete View Help Exit), show_help: :always)

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
        array = GetDateTime.event_array(date)
        puts GetDateTime.no_of_events(array)
        GetDateTime.list_events(array)
    when 'Help'
        system('clear')
        puts help
    when 'Exit'
        system('clear')
        return
    end
end

