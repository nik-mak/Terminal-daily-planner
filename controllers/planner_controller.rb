require_relative './../models/enums'
require 'tty-font'

class PlannerController
  include Enums
  def initialize(planner_model, planner_view)
    @planner_model = planner_model
    @planner_view = planner_view
  end

  # Run the app
  def run
    @planner_view.welcome
    @planner_view.proverb
    @planner_view.todays_events
    loop do
      options = @planner_view.options
      case options
      when Enums.Add
        date = @planner_view.get_date
        time = @planner_view.get_time
        title = @planner_view.get_title
        @planner_model.add_event(date, time, title)
        @planner_model.sort_file
      when Enums.ViewDay
        date = @planner_view.get_date
        events = @planner_model.events_date(date)
        @planner_view.no_of_events(events)
        @planner_view.show_events(events)
      when Enums.FindEvent
        title = @planner_view.get_title
        events = @planner_model.events_title(title)
        @planner_view.no_of_events(events)
        @planner_view.show_events(events)
      when Enums.DeleteEvent
        date = @planner_view.get_date
        title = @planner_view.get_title
        @planner_model.delete_event(date, title)
      when Enums.Help
        @planner_view.help
      when Enums.Exit
        @planner_view.goodbye
        return
      end
    end
  end 
end
