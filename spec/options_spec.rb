require './planner'

describe Options do
    describe '#get_option' do
        it 'returns the option input by the user' do
            allow(Options).to receive(:gets).and_return('1')
            expect(Options.get_option).to eq('1')
        end

        it 'raises an exception if option entered is empty' do
            allow(Options).to receive(:gets).and_return('     ')
            expect { Options.get_option }.to raise_error(NoInputError)
        end

        it 'raises an exception if option entered is not an option' do
            allow(Options).to receive(:gets).and_return('6')
            expect { Options.get_option }.to raise_error(InvalidInputError)
        end

    end
end