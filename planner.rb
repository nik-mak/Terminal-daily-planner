require 'csv'
require 'json'
require 'date'
require 'tty-prompt'
require 'rainbow'
require 'httparty'

require_relative('./date_time')
require_relative('./eventinfo')

prompt = TTY::Prompt.new(interrupt: :exit)

def help
    return "Hachi is your daily planner right here in your terminal! You can navigate through the options with the arrow keys.

    Add:      allows you to add an event you just need to specify what day, what time, and give it a name.
    Delete:   allows you to delete an event.
    View:     allows you to view the events of a specific day! you only need to specify the date.
    Help:     will show you how to use this app.
    Exit:     will close the planner.
    
    Date can be entered as dd/mm/yyyy or just the days number and the month and year will default to the current month and year.
    All times must be entered in 24hr format.
    "
end

ARGV.each do |arg|
	if arg == "-h" || arg == "--help"
		puts help
		return
	end
end

system("clear")

# welcome message
puts Rainbow("Hachi v1.0").goldenrod

# todays date
puts Rainbow("Today is #{Time.now.strftime("%A, %d of %B")}").goldenrod

# fetch todays date
today = Time.now.strftime("%d %m %y")
# convert todays date to same format as csv file
today_date = Date.parse(today).to_s
# create array of todays events
today_array = EventInfo.event_array(today_date)
# display all events for today
puts EventInfo.no_of_events(today_array)
EventInfo.list_events(today_array)

# fetch proverb
response = HTTParty.get('https://zenquotes.io/api/random')
result = JSON.parse(response.body)[0]
puts Rainbow(result["q"] + " - " + result["a"]).lightcoral

while true
    option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w(Add View Delete Help Exit), show_help: :always, active_color: :yellow)

    case option
    when 'Add'
        system("clear") 

        # get the date from the user
        begin
            ask_date = prompt.ask(Rainbow("Please enter a day [dd/mm/yyyy]").orange, required: true)
            date = DateAndTimes.get_date(ask_date)
        rescue
            puts Rainbow("Please enter a valid date.").rebeccapurple
            retry
        end

        # get the time from the user
        begin
            ask_time = prompt.ask(Rainbow("Please enter a time? [hh:mm]").orange, required: true)
            time = DateAndTimes.get_time(ask_time)
        rescue
            puts Rainbow("Please enter a valid time").rebeccapurple
            retry
        end
        
        # get the details from the user
        title = prompt.ask(Rainbow("What would you like to call this event?").orange)

        # confirm all details of the event with the user
        puts Rainbow("Are these the correct details?").blanchedalmond
        confirm = prompt.yes?(Rainbow("date: #{date}, time: #{time}, details: #{title}").wheat)

        # write the event to the file
        if confirm == true
            CSV.open('dates.csv', 'a') { |csv| csv << [date, time, title] }
            
            rows = []
            CSV.foreach('dates.csv', headers: true) do |row|
                rows << row.to_h
            end

            rows.sort_by! { |row| row['time'] }

            CSV.open("dates.csv", "w") do |csv|
                csv << rows.first.keys
                rows.each do |hash|
                  csv << hash.values
                end
            end
        end

    when 'View'
        system('clear')

        # get the date from the user
        begin
            ask_date = prompt.ask(Rainbow("What day would you like to view? [dd/mm/yyyy]").orange, required: true)
            date = DateAndTimes.get_date(ask_date)
        rescue
            puts Rainbow("Please enter a valid date.").rebeccapurple
            retry
        end

        # create array of events for that day
        array = EventInfo.event_array(date)
        
        # display how many events for that day
        puts EventInfo.no_of_events(array)

        # display events for that day
        EventInfo.list_events(array)

    when 'Delete'
        system('clear')

        # get the date from the user
        begin
            ask_date = prompt.ask(Rainbow("Please enter the day for the event you want to delete [dd/mm/yyyy]").orange, required: true)
            date = DateAndTimes.get_date(ask_date)
        rescue
            puts Rainbow("Please enter a valid date.").rebeccapurple
            retry
        end

        # display events for that day
        array = EventInfo.event_array(date)
        EventInfo.list_events(array)
        
        # get details for the event to be deleted
        title = prompt.ask(Rainbow("What event would you like to delete?").orange)

        # confirm details
        puts Rainbow("Are these the correct details?").blanchedalmond
        confirm = prompt.yes?(Rainbow("Are you sure you want to delete: #{title}?").wheat)

        # delete event from csv
        if confirm == true
            EventInfo.delete_event(date, title)
        end
    when 'Help'
        system('clear')
        puts help
    when 'Exit'
        system('clear')
        return
    end
end

