require 'csv'
require 'date'
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

##### put affirmation here

today_date = DateAndTimes.today
array = EventInfo.event_array(today_date)
puts Rainbow(EventInfo.no_of_events(array)).burlywood
EventInfo.list_events(array)

while true
    option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w(Add Delete View Help Exit), show_help: :always, active_color: :yellow)

    case option
    when 'Add'
        system("clear") 
        prompt = TTY::Prompt.new

        # get the date from the user
        date_string = prompt.ask("Please enter a day [dd/mm/yyyy]", required: true)
        date = DateAndTimes.get_date(date_string)

        # get the time from the user
        time_string = prompt.ask("Please enter a time? [hh:mm am/pm]", required: true)
        time = DateAndTimes.get_time(time_string)
        
        # get the details from the user
        details = prompt.ask("What would you like to call this event?")

        # confirm all details of the event with the user
        puts "Are these the correct details?"
        confirm = prompt.yes?("Date: #{date}, Time: #{time}, Details: #{details}")

        # write the event to the file
        if confirm == true
            csvfile = CSV.open('dates.csv', 'a')
            csvfile << [date, time, details]
            csvfile.close
        else
            puts "too bad"
        end

    when 'Delete'

    when 'View'
        system('clear')

        # get the date to view
        date_string = prompt.ask(Rainbow("Please enter a day [dd/mm/yyyy]").khaki, required: true)
        date = DateAndTimes.get_date(date_string)

        # create array of events for that day
        array = EventInfo.event_array(date)
        
        # display how many events for that day
        puts EventInfo.no_of_events(array)

        # display events for that day
        EventInfo.list_events(array)
    when 'Help'
        system('clear')
        puts help
    when 'Exit'
        system('clear')
        return
    end
end

