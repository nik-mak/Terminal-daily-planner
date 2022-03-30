# frozen_string_literal: true

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
  describe '#no_of_events' do
    it 'should retrun the number of events on that day' do
      expect(EventInfo.no_of_events(%w[a b c])).to eq 'You have 3 events!'
    end
  end
end