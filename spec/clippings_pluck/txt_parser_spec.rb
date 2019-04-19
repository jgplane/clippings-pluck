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

    describe 'this clippings array returned after parsing a file with out-of-order notes' do
      before :all do
        string = File.open("#{RSPEC_ROOT}/resources/smart_note_attachment_case.txt", "rb").read
        @clippings = described_class.new.run(string)
      end

      it 'has one clipping from test data' do
        expect(@clippings.length).to eq(3)
      end

      it 'returns highlights in the correct order' do
        expect(@clippings.first[:quote]).to eq('Highlight #1')
      end

      it 'attaches the note to the correct highlight' do
        expect(@clippings[1][:note]).to eq('Note content')
      end

      it 'does not incorrectly attach the note to the closest highlight' do
        expect(@clippings[0][:note]).not_to eq('Note content')
      end
    end
  end
end
