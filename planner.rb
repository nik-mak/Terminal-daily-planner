require 'csv'
require 'tty-prompt'
require 'rainbow'

require_relative('./date_time')
require_relative('./eventinfo')

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

date = DateAndTimes.today
array = EventInfo.event_array(date)
puts Rainbow(EventInfo.no_of_events(array)).burlywood
EventInfo.list_events(array)

while true
    option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w(Add Delete View Help Exit), show_help: :always, active_color: :yellow)

    case option
    when 'Add'
        system("clear") 
        prompt = TTY::Prompt.new
        date_string = prompt.ask("Please enter a day [dd/mm/yyyy]", required: true)
        date = DateAndTimes.get_date(date_string)

        time_string = prompt.ask("Please enter a time? [hh:mm am/pm]", required: true)
        time = DateAndTimes.get_time(time_string)
        
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
    
    when 'Help'
        system('clear')
        puts help
    when 'Exit'
        system('clear')
        return
    end
end

