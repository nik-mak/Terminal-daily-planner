# frozen_string_literal: true

require 'csv'
require 'json'
require 'date'
require 'tty-prompt'
require 'rainbow'
require 'httparty'

# files
require_relative('./modules/date_time')
require_relative('./modules/eventinfo')
require_relative('./modules/open')
require_relative('./modules/view_day')
require_relative('./modules/file_ops')

prompt = TTY::Prompt.new(interrupt: :exit)

def help
  "Hachi is your daily planner right here in your terminal! You can navigate through the options with the arrow keys.

  Add:      allows you to add an event you just need to specify what day, what time, and give it a name.
  Delete:   allows you to delete an event.
  View:     allows you to view the events of a specific day! you only need to specify the date.
  Help:     will show you how to use this app.
  Exit:     will close the planner.

  Date can be entered as dd/mm/yyyy or just the days number and the month and year will
  default to the current month and year.
  All times must be entered in 24hr format."
end

ARGV.each do |arg|
  arg.include?('-h') ? (return puts help) : next
end

system('clear')

# welcome message
puts Rainbow('Hachi v1.0').goldenrod
puts Rainbow("Today is #{Time.now.strftime('%A, %d of %B')}").goldenrod
Today.prog_open
Today.proverb

loop do
  option = prompt.select(Rainbow('What would you like to do?').palegoldenrod, %w[Add View Delete Help Exit], show_help: :always, active_color: :yellow)
  case option
  when 'Add'
    # get the date from the user
    begin
      date = DateAndTimes.get_date(prompt.ask(Rainbow('Please enter a day [dd/mm/yyyy]').orange, required: true))
    rescue Date::Error
      puts Rainbow('Please enter a valid date.').rebeccapurple
      retry
    end

    # get the time from the user
    begin
      time = DateAndTimes.get_time(prompt.ask(Rainbow('Please enter a time? [hh:mm]').orange, required: true))
    rescue Date::Error
      puts Rainbow('Please enter a valid time').rebeccapurple
      retry
    end

    # get the details from the user
    title = prompt.ask(Rainbow('What would you like to call this event?').orange)

    # confirm all details of the event with the user
    puts Rainbow('Are these the correct details?').blanchedalmond
    confirm = prompt.yes?(Rainbow("date: #{date}, time: #{time}, details: #{title}").wheat)

    # write the event to the file
    confirm == true ? Write.new_event : next
  when 'View'
    view = prompt.select(Rainbow('What would you like to view?').palegoldenrod, %w[Day Event], show_help: :always, active_color: :yellow)
    case view
    when 'Day'
      begin
        date = DateAndTimes.get_date(prompt.ask(Rainbow('What day would you like to view? [dd/mm/yyyy]').orange, required: true))
      rescue Date::Error
        puts Rainbow('Please enter a valid date.').rebeccapurple
        retry
      end
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
