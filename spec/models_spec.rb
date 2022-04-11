require_relative './../models/event_details'
require_relative './../models/events'

describe EventDetails do
  it 'should initialize with 3 arguments' do
    expect{ EventDetails.new }.to raise_error(ArgumentError)
    expect{ EventDetails.new(1) }.to raise_error(ArgumentError)
    expect{ EventDetails.new(1, 2) }.to raise_error(ArgumentError)
  end
  describe '#new_event' do
    before (:each) do
      @new_event = EventDetails.new('a', 'b', 'c')
    end
    it 'should return an array' do
      expect(@new_event.new_event).to be_an_instance_of(Array)
    end
  end
end
describe Events do
  before (:each) do
    @events = Events.new
    Events.class_variable_set :@@file, 'files/testing.csv'
  end
  describe 'Fetch Events' do
    it 'should return an array' do
      expect(@events.events_date('01/01/2022')).to be_an_instance_of(Array)
    end
    it 'should return an array for a given date' do
      expect(@events.events_date('01/01/2022')).to eq([{'date' => '01/01/2022', 'time' => '01:11', 'title' => 'One'}])
    end
    it 'should return all events with the given title' do
      expect(@events.events_title('One')).to eq([{'date' => '01/01/2022', 'time' => '01:11', 'title' => 'One'}])
    end
    it 'should return the number of events in the array' do
      expect(@events.events_date('01/01/2022').length).to eq(1)
    end
  end
  describe '#add_event' do
    before (:each) do
      @events = Events.new
      Events.class_variable_set :@@file, 'files/testing.csv'
      @length = IO.readlines('files/testing.csv').size
      @new_length = @length + 1
    end
    it 'should add a new row to the file' do
      expect(@events.add_event('04/04/2022', '04:44', 'Four')).to eq(@new_length)
    end
  end
  describe '#delete_event' do
    before (:each) do
      @events = Events.new
      Events.class_variable_set :@@file, 'files/testing.csv'
      @length = IO.readlines('files/testing.csv').size
      @new_length = @length - 1
    end
    it 'should delete a row from the file' do
      expect(@events.delete_event('01/01/2022', 'One')).to eq(@new_length)
    end
  end
end