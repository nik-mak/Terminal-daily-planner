require_relative './../models/enums'
require 'tty-prompt'
require 'httparty'

class EventView
  def initialize(event_model)
    @event_model = event_model
  end

  # Display the menu options and return the selected option
  def options
    prompt = TTY::Prompt.new(interrupt: :exit)
    options = prompt.select('What would you like to do?', Enums.Options, show_help: :always)
    return options
  end

  # Get the date from the user
  def get_date
    begin
      prompt = TTY::Prompt.new(interrupt: :exit)
      collect_date = prompt.ask('Please enter a day [dd/mm/yyyy]')
      if collect_date.nil?
        collect_date = Time.now.strftime('%d/%m/%Y')
      end
      date = Date.parse(collect_date)
    rescue Date::Error
      puts 'Please enter a valid date'
      retry
    rescue TypeError
      puts 'Please enter a date'
      retry
    end
    return date.strftime('%d/%m/%Y').to_s
  end

  # Get the time from the user
  def get_time
    begin
      prompt = TTY::Prompt.new(interrupt: :exit)
      collect_time = prompt.ask('Please enter a time [hh:mm]', required: true)
      time = DateTime.strptime(collect_time.to_s, '%H:%M')
    rescue Date::Error
      puts 'Please enter a valid time'
      retry
    end
    return time.strftime('%H:%M')
  end

  # Get the title from the user
  def get_title
    prompt = TTY::Prompt.new(interrupt: :exit)
    title = prompt.ask('Please provide a title:', required: true)
    return title
  end

  # Display how many events for a given array
  def no_of_events(events)
    puts
    events.length == 0 ? (puts 'You have no events') : (puts "You have #{events.length} events")
  end

  # Display all the events within a given array of hashes
  def show_events(events)
    events.each do |event|
      puts "#{event['date']} #{event['time']} -- #{event['title']}"
    end
    puts
  end

  # Display opening messages
  def welcome
    system('clear')
    font = TTY::Font.new(:doom)
    puts font.write('Hachi')
    puts "Today is #{Time.now.strftime('%A, %d %B')}"
  end

  # Display todays events
  def todays_events
    date = Time.now.strftime('%d/%m/%Y')
    events = @event_model.events_date(date)
    puts
    show_events(events)
  end

  # Display a proverb from a HTTP API
  def proverb
    response = HTTParty.get('https://zenquotes.io/api/random')
    result = JSON.parse(response.body)[0]
    puts "#{result['q']} - #{result['a']}"
  end

  # Display help documentation
  def help
    File.foreach('files/help.txt') do |each|
      puts each
    end
  end

  # Display goodbye message
  def goodbye
    puts 'See you later, aligator!'
  end
end
