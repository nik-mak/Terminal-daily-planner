require './date_time'

describe DateAndTimes do

    describe '#get_date' do
        it 'should return the date' do
            expect(DateAndTimes.get_date('25/03/2022')).to eq '2022-03-25'
        end
    end

    describe '#get_time' do
        it 'should return the time' do
            expect(DateAndTimes.get_time('9:30')).to eq ' 9:30'
        end
    end

end