# frozen_string_literal: true

#gems
require 'csv'
require 'json'
require 'date'
require 'tty-prompt'
require 'rainbow'
require 'httparty'

# files
require_relative('./modules/date_time')
require_relative('./modules/eventinfo')
require_relative('./modules/today')
require_relative('./modules/view')
require_relative('./modules/file_ops')

prompt = TTY::Prompt.new(interrupt: :exit)

ARGV.each do |arg|
  if arg == '-h' || arg == '--help'
    File.foreach('./files/help.txt') do |each|
      puts each
    end
  elsif arg == ''
  end
  exit
end

system('clear')

# welcome message
puts Rainbow('Hachi v1.0').goldenrod
puts Rainbow("Today is #{Time.now.strftime('%A, %d of %B')}").goldenrod
Rainbow(Today.prog_open).orange
Today.proverb

loop do
  option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w[Add View Delete Help Exit], show_help: :always, active_color: :yellow)
  case option
  when 'Add'
    # get the info from the user
    begin
      date = DateAndTimes.get_date(prompt.ask(Rainbow('Please enter a day [dd/mm/yyyy]').orange, required: true))
    rescue Date::Error
      puts Rainbow('Please enter a valid date.').rebeccapurple
      retry
    end

    begin
      time = DateAndTimes.get_time(prompt.ask(Rainbow('Please enter a time? [hh:mm]').orange, required: true))
    rescue Date::Error
      puts Rainbow('Please enter a valid time').rebeccapurple
      retry
    end

    title = prompt.ask(Rainbow('What would you like to call this event?').orange)

    # confirm details of the event with the user
    puts Rainbow('Are these the correct details?').blanchedalmond
    confirm = prompt.yes?(Rainbow("date: #{date}, time: #{time}, details: #{title}").wheat)

    # write the event to the file
    confirm == true ? Write.new_event(date, time, title) : next
  when 'View'
    view = prompt.select(Rainbow('What would you like to view?').palegoldenrod, %w[Day Event], show_help: :always, active_color: :yellow)
    case view
    when 'Day'
      # get details from user
      begin
        date = DateAndTimes.get_date(prompt.ask(Rainbow('What day would you like to view? [dd/mm/yyyy]').orange, required: true))
      rescue Date::Error
        puts Rainbow('Please enter a valid date.').rebeccapurple
        retry
      end
      # display events
      View.list_events_day(date)
      next
    when 'Event'
      event = prompt.ask(Rainbow('What event would you like to view?').orange, required: true)
      View.list_events_name(event)
      next
    end
  when 'Delete'
    system('clear')
    # get the date from the user
    begin
      date = DateAndTimes.get_date(prompt.ask(Rainbow('Enter the date of the event to delete [dd/mm/yyyy]').orange, required: true))
    rescue Date::Error
      puts Rainbow('Please enter a valid date.').rebeccapurple
      retry
    end
    # display events for that day
    View.list_events_day(date)
    # get details for the event to be deleted
    title = prompt.ask(Rainbow('What event would you like to delete?').orange)
    # confirm details
    confirm = prompt.yes?(Rainbow("Are you sure you want to delete: #{title}?").wheat)
    # delete event from csv
    confirm == true ? Write.delete_event(date, title) : next
  when 'Help'
    puts help
  when 'Exit'
    return
  end
end
