require 'csv'
require "tty-prompt"

prompt = TTY::Prompt.new


class NoInputError < StandardError
    def message
        puts "Please enter an option"
    end
end

class InvalidInputError < StandardError
    def message
        puts "Please enter a valid option"
    end
end


system("clear")
puts "Melissa v0.1"
puts "Today is #{Time.now.strftime("%A, %d of %B")}" 
# puts affirmation here
# put todays events here

while true

    option = prompt.select('What would you like to do?', %w(Add Delete View Help Exit))

    case option
    when 'Add'
        system("clear") 
        date_string = prompt.ask("What day would you like to create the event for? [dd/mm/yyyy]")
        date = Date.parse(date_string).to_s
    
        time_string = prompt.ask("What time would you like the event to start? [hh:mm AM/PM]")
        time_p = DateTime.strptime("#{time_string}", '%I:%M %p')
        time = time_p.strftime('%I:%M %p')
    
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
        view_date_string = prompt.ask("What day would you like to view?")
        view_date = Date.parse(view_date_string).to_s
    
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

    when 'Exit'
        return
    end
end

