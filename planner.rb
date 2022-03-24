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
        
    when '2'

    when '3'
       
    when '4'

    when '5'
        return
    end
end

