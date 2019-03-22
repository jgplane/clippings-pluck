require "spec_helper"
require "csv"

RSpec.describe ClippingsPluck::CsvParser do
  subject(:csv_parser) { described_class.new }

  describe 'Run' do
    before :all do
      ROOT = File.dirname __FILE__
      string = File.open("#{RSPEC_ROOT}/clippings.csv", "rb").read
      @clippings = described_class.new.run(string)
    end

    it 'parses the correct book title' do
      expect(@clippings.first[:book_title]).to eq("Book Title")
    end

    it 'parses the correct author' do
      expect(@clippings.first[:author]).to eq("Author")
    end
  end
end
