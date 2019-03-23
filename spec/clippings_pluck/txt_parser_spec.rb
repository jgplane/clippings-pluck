require "spec_helper"

RSpec.describe ClippingsPluck::TxtParser do
  context '#run completes successfully' do
    describe 'the clippings array returned after parsing a file without a note' do
      before :all do
        string = File.open("#{RSPEC_ROOT}/resources/my_clippings_no_notes.txt", "rb").read
        @clippings = described_class.new.run(string)
      end

      it 'is not an Array' do
        expect(@clippings).not_to be_an_instance_of(Array)
      end

      it 'is of type Clippings' do
        expect(@clippings).to be_an_instance_of(ClippingsPluck::Clippings)
      end

      it 'has one clipping from test data' do
        expect(@clippings.length).to eq(1)
      end
    end

    describe 'the clippings array returned after parsing a file with a note' do
      before :all do
        string = File.open("#{RSPEC_ROOT}/resources/my_clippings_noted.txt", "rb").read
        @clippings = described_class.new.run(string)
      end

      it 'has one clipping from test data' do
        expect(@clippings.length).to eq(1)
      end

      it 'has author names separated by a comma' do
        expect(@clippings.first[:author]).to eq('Ms Author')
      end

      it 'has the correct note' do
        expect(@clippings.first[:note]).to eq('This is a note')
      end
    end
  end
end
