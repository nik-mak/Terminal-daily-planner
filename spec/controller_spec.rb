require_relative './../models/events'
require_relative './../views/planner_view'
require_relative './../controllers/planner_controller'

describe PlannerController do
  before (:each) do
    @events = Events.new
    @views = EventView.new(@events)
    @controller = PlannerController.new(@events, @views)
  end
  it 'should initialise with 2 arguments' do
    expect{ PlannerController.new }.to raise_error(ArgumentError)
    expect{ PlannerController.new(@events) }.to raise_error(ArgumentError)
  end
end
