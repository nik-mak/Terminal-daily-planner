require 'csv'
module EventInfo
    def self.date_event_array(date)
        array = []
        csv = CSV.open('dates.csv', 'r', headers: true)
        csv.select do |row|
            if row['date'] == date
                array << row.to_h
            end
        end
        if array.length == 0
            puts Rainbow("There are no events.").rebeccapurple
            return array
        else
            return array
        end
    end

    def self.name_event_array(name)
        array = []
        csv = CSV.open('dates.csv', 'r', headers: true)
        csv.select do |row|
            if row['title'] == name
                array << row.to_h
            end
        end
        if array.length == 0
            puts Rainbow("There are no events with that name.").rebeccapurple
            return array
        else
            return array
        end
    end

    def self.no_of_events(array)
        return Rainbow("You have #{array.length} events!").orange
    end

    def self.list_events(array)
        array.each do |hash|
            puts Rainbow("You have: #{hash["title"]} on #{hash["date"]} at #{hash["time"]}").burlywood
        end
    end

    def self.delete_event(date, title)
        File.open('dates.csv') do |file|
            table = CSV.parse(file, headers: true)
            table.delete_if {|row| (row["title"] == title) && (row["date"] == date)}
            result = File.write('dates.csv', table.to_csv)
        end
    end

    def self.sort_csv
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
end