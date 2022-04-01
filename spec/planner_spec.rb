require './modules/date_time'
require './modules/eventinfo'
require './modules/write'

describe DateAndTimes do
  describe '#get_date' do
    it 'should return the date' do
      expect(DateAndTimes.get_date('25/03/2022')).to eq '2022-03-25'
    end
    it 'should return an error for invalid date' do
      expect { DateAndTimes.get_date('AA/BB/2022') }.to raise_error(Date::Error)
    end
  end
  describe '#get_time' do
    it 'should return the time' do
      expect(DateAndTimes.get_time('9:30')).to eq '09:30'
    end
    it 'should return an error for invalid time' do
      expect { DateAndTimes.get_time('a:30') }.to raise_error(Date::Error)
    end
  end
end

describe EventInfo do
  describe '#date_event_array' do
    it 'should return the events for the given date' do
      expect(EventInfo.date_event_array('2022-04-01')).to include({ 'date' => '2022-04-01',
                                                                    'time' => '09:30',
                                                                    'title' => 'Test 6' })
    end
  end
  describe '#name_event_array' do
    it 'should return the events with a given name' do
      expect(EventInfo.name_event_array('Test 6')).to include({ 'date' => '2022-04-01',
                                                                'time' => '09:30',
                                                                'title' => 'Test 6' })
    end
  end
  describe '#no_of_events' do
    it 'should return a string with the number of events' do
      expect(EventInfo.no_of_events([{ a: 'b' }, { c: 'd' }])).to eq 'You have 2 events!'
    end
  end
end
