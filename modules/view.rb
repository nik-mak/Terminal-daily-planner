require 'csv'
require 'json'
require 'date'
require 'rainbow'
require_relative('./date_time')
require_relative('./eventinfo')

# Used to view by either date or title
module View
  def self.list_events_day(date)
    array = EventInfo.date_event_array(date)
    array.empty? ? (puts Rainbow('There are no events.').rebeccapurple) : (puts EventInfo.no_of_events(array))
    EventInfo.list_events(array)
  end

  def self.list_events_name(event)
    array = EventInfo.name_event_array(event)
    array.empty? ? (puts Rainbow('There are no events with that name.').rebeccapurple) : EventInfo.list_events(array)
  end
end