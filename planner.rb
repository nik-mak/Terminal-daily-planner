require 'csv'
require "tty-prompt"

prompt = TTY::Prompt.new

system("clear")
puts "Melissa v1.0"
puts "Today is #{Time.now.strftime("%A, %d of %B")}" 
# puts affirmation here
home_array = []
today = Time.now.strftime("%d %m %y")
today_date = Date.parse(today).to_s
    
csv = CSV.open('dates.csv', 'r', headers: true)
csv.select do |row|
    if row['Date'] == today_date
        home_array << row.to_h
    end
end
puts "You have #{home_array.length} events today!"

home_array.each do |hash|
    puts "You have #{hash["Details"]} at #{hash["Time"]}"
end

while true
    option = prompt.select('What would you like to do?', %w(Add Delete View Help Exit))

    case option
    when 'Add'
        system("clear") 
        begin
            date_string = prompt.ask("What day would you like to create the event for? [dd/mm/yyyy]")
            date = Date.parse(date_string).to_s
        rescue
            puts "Please enter a valid date."
            retry
        end
    
        begin
            time_string = prompt.ask("What time would you like the event to start? [hh:mm AM/PM]")
            time_p = DateTime.strptime("#{time_string}", '%I:%M %p')
            time = time_p.strftime('%I:%M %p')
        rescue
            puts "Please enter a valid time"
            retry
        end
    
        details = prompt.ask("What would you like to call this event?")
    
        puts "Are these the correct details?"
        confirm = prompt.yes?("Date: #{date}, Time: #{time}, Details: #{details}")
        if confirm = 'yes' || confirm = 'y'
            csvfile = CSV.open('dates.csv', 'a')
            csvfile << [date, time, details]
            csvfile.close
        end
    when 'Delete'

    when 'View'
        array = []
        begin
            view_date_string = prompt.ask("What day would you like to view?")
            view_date = Date.parse(view_date_string).to_s
        rescue
            puts "Please enter a valid date."
            retry
        end
    
        csv = CSV.open('dates.csv', 'r', headers: true)
        csv.select do |row|
            if row['Date'] == view_date
                array << row.to_h
            end
        end
        puts "You have #{array.length} events on that day!"

        array.each do |hash|
            puts "You have #{hash["Details"]} at #{hash["Time"]}"
        end
    when 'Help'
        system('clear')
        puts "Melissa is your daily planner right here in your terminal!"
        puts "You can navigate through the options with your arrow keys"
        puts "Add: allows you to add an event you just need to specify what day, what time, and give it a name"
        puts "Delete: allows you to delete an event"
        puts "View: allows you to view the events of a specific day! you only need to specify the date."
        puts "Help: will show you how to use this app"
        puts "Exit: will close the planner."
    when 'Exit'
        system('clear')
        return
    end
end

