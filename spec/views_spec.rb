require_relative './../models/events'
require_relative './../views/planner_view'

describe EventView do
  before (:each) do
    @events = Events.new
    @views = EventView.new(@events)
  end
  describe '#no_of_events' do
    it 'should puts a string with the number of events for that day' do
      expect(@views.no_of_events([{'date' => '30/04/2022', 'time' => '03:30', 'title' => 'Beta'}])).to be(nil)
    end
  end
  describe '#show_events' do
    it 'should show the events within an array' do
      expect(@views.show_events([{'date' => '30/04/2022', 'time' => '03:30', 'title' => 'Beta'}])).to be(nil)
    end
  end
  describe '#todays_events' do
    it 'should put the events for today' do
      expect(@views.todays_events).to be(nil)
    end
  end
  describe '#help' do
    it 'should display the contents from the help file' do
      expect(@views.help).to be(nil)
    end
  end
  describe '#goodbye' do
    it 'should display a goodbye message' do
      expect(@views.goodbye).to be(nil)
    end
  end
end