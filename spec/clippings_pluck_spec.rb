require "spec_helper"
require "csv"

RSpec.describe ClippingsPluck do
  it "has a version number" do
    expect(ClippingsPluck::VERSION).not_to be nil
  end

  describe 'Plucker' do
    before :each do
      @plucker = ClippingsPluck::Plucker.new
    end

    let(:data) {
      "Test Book 2 (Mr Author)\n- Your Highlight on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a quote from"\
      "Test Book 2\n=========="
    }

    let(:clipping_data) {
      "Test Book 2 (Author, Ms)\n- Your Highlight on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a quote from"\
      "Test Book 2\n=========="\
      "Test Book 2 (Author, Ms)\n- Your Note on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a note"\
      "\n=========="
    }

    it 'parses one candidate from test data' do
      candidates = @plucker.run(data)

      expect(candidates.length).to eq(1)
    end

    it 'parses author names separated by a comma' do
      candidates = @plucker.run(clipping_data)

      expect(candidates.first[:author]).to eq('Ms Author')
    end

    it 'parses assigns notes to candidates' do
      candidates = @plucker.run(clipping_data)
      expect(candidates.first[:note]).to eq('This is a note')
    end
  end

  describe 'CsvPlucker' do
    before :all do
      ROOT = File.dirname __FILE__
      File.open("#{ROOT}/clippings.csv") do |f|
        @string = f.read
      end

      @csv_plucker = ClippingsPluck::CsvPlucker.new
      @candidates = @csv_plucker.run(@string)
    end

    # Notes for implementation:
    #
    # SEPARATOR = "----------------------------------------------\t\t\t\r\t\t\t\r"
    # metadata, clippings = @string.split(SEPARATOR)
    # CSV.parse(clippings, headers: true, col_sep: "\t")
    #
    it 'parses the correct book title' do
      expect(@candidates.first[:book_title]).to eq("Book Title")
    end
  end
end
