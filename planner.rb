require_relative './models/events'
require_relative './views/planner_view'
require_relative './controllers/planner_controller'

planner_model = Events.new
planner_view = EventView.new(planner_model)
planner_controller = PlannerController.new(planner_model, planner_view)
planner_controller.run
