require "spec_helper"
require "csv"

RSpec.describe ClippingsPluck::CsvParser do
  context '#run completes successfully' do
    before :all do
      string = File.open("#{RSPEC_ROOT}/resources/clippings.csv", "rb").read
      @clippings = described_class.new.run(string)
    end

    describe 'the clippings array returned by .run' do
      it 'is not an Array' do
        expect(@clippings).not_to be_an_instance_of(Array)
      end

      it 'is of type Clippings' do
        expect(@clippings).to be_an_instance_of(ClippingsPluck::Clippings)
      end

      it 'includes 2 clippings' do
        expect(@clippings.length).to eq(2)
      end
    end

    describe 'the first clipping returned by .run' do
      subject(:first) { @clippings.first }

      it 'has the correct book title' do
        expect(first[:book_title]).to eq("Title")
      end

      it 'has the correct author' do
        expect(first[:author]).to eq("Author Name")
      end

      it 'has the correct highlight' do
        expect(first[:quote]).to eq("Highlight 1")
      end

      it 'has the correct note' do
        expect(first[:note]).to eq("Note 1-1")
      end

      it 'has the correct location' do
        expect(first[:location]).to eq("221")
      end

      it 'doesnt include csv headers' do
        expect(first).not_to have_key('Annotation Type')
        expect(first).not_to have_key('Annotation')
        expect(first).not_to have_key('Starred?')
        expect(first).not_to have_key('Location')
      end
    end

    describe 'the second clipping returned by .run' do
      subject(:second) { @clippings[1] }

      it 'has the correct book title' do
        expect(second[:book_title]).to eq("Title")
      end

      it 'has the correct author' do
        expect(second[:author]).to eq("Author Name")
      end

      it 'has the correct highlight' do
        expect(second[:quote]).to eq("Highlight 2")
      end

      it 'concatenates multiple notes into one' do
        expect(second[:note]).to eq("Note 2-1 | Note 2-2")
      end

      it 'has the correct location' do
        expect(second[:location]).to eq("384")
      end
    end
  end
end
