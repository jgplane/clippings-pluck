require "spec_helper"
require "csv"

RSpec.describe ClippingsPluck::CsvParser do
  subject(:csv_parser) { described_class.new }

  describe 'Run' do
    before :all do
      ROOT = File.dirname __FILE__
      File.open("#{ROOT}/clippings.csv") do |f|
        @string = f.read
      end

      @candidates = csv_parser.run(@string)
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
