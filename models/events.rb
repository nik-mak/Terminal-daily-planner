require 'csv'

class Events
  @@file = 'files/planner.csv'

  def initialize
    @events = []
  end

  # Add an event to the csv file
  def add_event(date, time, title)
    a = EventDetails.new(date, time, title)
    b = a.new_event
    CSV.open(@@file, 'a') do |csv|
      csv << b
    end
    return IO.readlines(@@file).size
  end

  # Delete an event from the csv file
  def delete_event(date, title)
    File.open(@@file) do |file|
      table = CSV.parse(file, headers: true)
      table.delete_if { |row| (row['date'] == date) && (row['title'] == title)}
      File.write(@@file, table.to_csv)
    end
    return IO.readlines(@@file).size
  end

  # View the events by date
  def events_date(date)
    @events = []
    csv = CSV.open(@@file, 'r', headers: true)
    csv.select do |row|
      row['date'] == date ? (@events << row.to_h) : next
    end
    return @events
  end

  # View events by title
  def events_title(title)
    @events = []
    csv = CSV.open(@@file, 'r', headers: true)
    csv.select do |row|
      row['title'] == title ? (@events << row.to_h) : next
    end
    return @events
  end

  # Sort the contents of the file by time
  def sort_file
    rows = []
    CSV.foreach(@@file, headers: true) do |row|
      rows << row.to_h
    end
    rows.sort_by! { |row| row['time'] }
    CSV.open(@@file, 'w') do |csv|
      csv << rows.first.keys
      rows.each { |hash| csv << hash.values }
    end
  end

  # Amount of events for a given day
  def length
    @events.length
  end
end
