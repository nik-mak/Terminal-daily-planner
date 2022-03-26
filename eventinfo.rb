require 'csv'
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
        return Rainbow("You have #{array.length} events!").orange
    end

    def self.list_events(array)
        array.each do |hash|
            puts Rainbow("You have #{hash["Details"]} at #{hash["Time"]}").burlywood
        end
    end
end