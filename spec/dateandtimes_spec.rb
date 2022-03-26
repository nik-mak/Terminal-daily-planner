require './date_time'

describe DateAndTimes do

    describe '#get_date' do
        it 'should return the date' do
            expect(DateAndTimes.get_date('25/03/2022')).to eq '2022-03-25'
        end

        it 'should raise an exception if invalid date was entered' do
            expect { DateAndTimes.get_date('ab/cd/efgh') }.to raise_error
        end

        it 'should raise an exception if no date was entered' do
            expect { DateAndTimes.get_date('   ') }.to raise_error
        end
    end

    describe '#get_time' do
        it 'should return the time' do
            expect(DateAndTimes.get_time('9:30 am')).to eq '09:30 AM'
        end

        it 'should raise error if no time was entered' do
            expect { DateAndTimes.get_time('   ') }.to raise_error
        end
    end

end