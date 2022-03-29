# frozen_string_literal: true

require 'csv'
require_relative('./date_time')
require_relative('./eventinfo')
require_relative('./view_day')

# For all file operations
module Write
  def self.new_event 
    CSV.open('dates.csv', 'a') { |csv| csv << [date, time, title] }
    EventInfo.sort_csv
  end

  def self.delete_event(date, title)
    File.open('dates.csv') do |file|
      table = CSV.parse(file, headers: true)
      table.delete_if { |row| (row['title'] == title) && (row['date'] == date) }
      File.write('dates.csv', table.to_csv)
    end
  end
end
