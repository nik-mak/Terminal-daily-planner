require 'csv'

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

module Options
    def self.get_option
        puts "Options: [1. Add, 2. Delete, 3. View, 4. Help, 5. Exit]"
        option = gets.strip
        raise(NoInputError) if option.empty?
        raise(InvalidInputError) if (option !~ (/[1-5]/))

        return option
    end

    def self.add
        puts "What day would you like to create the event for? [dd/mm/yyyy]"
        date_string = gets.chomp.strip
        date = Date.parse(date_string).to_s
    
        puts "What time would you like the event to start? [hh:mm]"
        time = gets.chomp.strip
    
        puts "What would you like to call this event?"
        details = gets.chomp.strip
    
        puts "Are these the correct details?"
        puts "Date: #{date}, Time: #{time}, Details: #{details}"
        confirm = gets.chomp
        
        if confirm = 'yes' || confirm = 'y'
            csvfile = CSV.open('dates.csv', 'a')
            csvfile << [date, time, details]
            csvfile.close
        end
    end

    def self.view
        array = []
        puts "What day would you like to view?"
        view_date_string = gets.chomp.strip
        view_date = Date.parse(view_date_string).to_s
    
        csv = CSV.open('dates.csv', 'r', headers: true)
        csv.each do |row|
            if row['Date'] == view_date
                array << row
            end 
        end
    
        puts array
    end
end

system("clear")
puts "Melissa v0.1"
puts "Today is #{Time.now.strftime("%A, %d of %B")}" 
# puts affirmation here
# put todays events here

while true
    begin
        opt = Options.get_option
    rescue NoInputError => e
        print e.message
        retry
    rescue InvalidInputError => e
        print e.message
        retry
    end

    case opt
    when '1'
        system("clear")
        Options.add
    when '2'

    when '3'
       system("clear")
       Options.view
    when '4'

    when '5'
        return
    end
end

