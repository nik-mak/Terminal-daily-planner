# internal gems
require 'csv'
require 'json'
require 'date'

# external gems
require 'tty-prompt'
require 'tty-font'
require 'rainbow'
require 'httparty'

# files
require_relative('./modules/date_time')
require_relative('./modules/eventinfo')
require_relative('./modules/today')
require_relative('./modules/view')
require_relative('./modules/write')

prompt = TTY::Prompt.new(interrupt: :exit)

ARGV.each do |arg|
  case arg
  when '-h' || '--help'
    File.foreach('./files/help.txt') do |each|
      puts each
    end
  when '-v' || '--version'
    puts 'Hachi version 1.0'
  end
  exit
end

system('clear')

# welcome message
font = TTY::Font.new(:doom)
puts Rainbow(font.write('Hachi')).goldenrod
puts Rainbow("Today is #{Time.now.strftime('%A, %d of %B')}").goldenrod
Today.prog_open
puts Today.proverb

loop do
  option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w[Add View Delete Help Exit], show_help: :always, active_color: :yellow)
  case option
  when 'Add'
    # get the info from the user
    begin
      date = DateAndTimes.get_date(prompt.ask(Rainbow('Please enter a day [dd/mm/yyyy]').orange, required: true, active_color: :yellow))
    rescue Date::Error
      puts Rainbow('Please enter a valid date.').rebeccapurple
      retry
    end

    begin
      time = DateAndTimes.get_time(prompt.ask(Rainbow('Please enter a time? [hh:mm]').orange, required: true, active_color: :yellow))
    rescue Date::Error
      puts Rainbow('Please enter a valid time').rebeccapurple
      retry
    end

    title = prompt.ask(Rainbow('What would you like to call this event?').orange, active_color: :yellow)

    # confirm details of the event with the user
    puts Rainbow('Are these the correct details?').blanchedalmond
    confirm = prompt.yes?(Rainbow("date: #{date}, time: #{time}, details: #{title}").wheat, active_color: :yellow)

    # write the event to the file
    confirm == true ? Write.new_event(date, time, title) : next
  when 'View'
    view = prompt.select(Rainbow('What would you like to view?').palegoldenrod, %w[Day Event], show_help: :always, active_color: :yellow)
    case view
    when 'Day'
      # get details from user
      begin
        date = DateAndTimes.get_date(prompt.ask(Rainbow('What day would you like to view? [dd/mm/yyyy]').orange, required: true, active_color: :yellow))
      rescue Date::Error
        puts Rainbow('Please enter a valid date.').rebeccapurple
        retry
      end
      # display events
      View.list_events_day(date)
      next
    when 'Event'
      event = prompt.ask(Rainbow('What event would you like to view?').orange, required: true, active_color: :yellow)
      View.list_events_name(event)
      next
    end
  when 'Delete'
    # get the date from the user
    begin
      date = DateAndTimes.get_date(prompt.ask(Rainbow('Enter the date of the event to delete [dd/mm/yyyy]').orange, required: true, active_color: :yellow))
    rescue Date::Error
      puts Rainbow('Please enter a valid date.').rebeccapurple
      retry
    end
    # display events for that day
    View.list_events_day(date)
    # get details for the event to be deleted
    title = prompt.ask(Rainbow('What event would you like to delete?').orange, active_color: :yellow)
    # confirm details
    confirm = prompt.yes?(Rainbow("Are you sure you want to delete: #{title}?").wheat, active_color: :yellow)
    # delete event from csv
    confirm == true ? Write.delete_event(date, title) : next
  when 'Help'
    File.foreach('./files/help.txt') do |each|
      puts each
    end
  when 'Exit'
    return
  end
end
