# frozen_string_literal: true

require 'csv'

# Used to manipulate the csv file to exract the data.
module EventInfo
  def self.date_event_array(date)
    array = []
    csv = CSV.open('dates.csv', 'r', headers: true)
    csv.select do |row|
      row['date'] == date ? (array << row.to_h) : next
    end
  end

  def self.name_event_array(name)
    array = []
    csv = CSV.open('dates.csv', 'r', headers: true)
    csv.select do |row|
      row['title'] == name ? (array << row.to_h) : next
    end
  end

  def self.no_of_events(array)
    "You have #{array.length} events!"
  end

  def self.list_events(array)
    array.each do |hash|
      puts Rainbow("You have: #{hash['title']} on #{hash['date']} at #{hash['time']}").burlywood
    end
  end

  def self.sort_csv
    rows = []
    CSV.foreach('dates.csv', headers: true) do |row|
      rows << row.to_h
    end
    rows.sort_by! { |row| row['time'] }
    CSV.open('dates.csv', 'w') do |csv|
      csv << rows.first.keys
      rows.each { |hash| csv << hash.values }
    end
  end
end
