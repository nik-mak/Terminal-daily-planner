require_relative './models/events'
require_relative './views/planner_view'
require_relative './controllers/planner_controller'

ARGV.each do |arg|
  case arg
  when '-h' || '--help'
    File.foreach('./files/help.txt') do |each|
      puts each
    end
  when '-v' || '--version'
    puts 'Hachi version 2.0'
  end
  exit
end

planner_model = Events.new
planner_view = EventView.new(planner_model)
planner_controller = PlannerController.new(planner_model, planner_view)
planner_controller.run
