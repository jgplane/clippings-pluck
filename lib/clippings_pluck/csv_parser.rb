module ClippingsPluck
  class CsvParser
    AMZN_DIVIDER = "----------------------------------------------\t\t\t\r\t\t\t\r"

    def initialize
      @clippings = Clippings.new
      @clipping = {}
    end

    def run(string)
      @raw_metadata, @clipping_data = string.split(AMZN_DIVIDER)
      @book, @authors = parse_metadata
      build_clippings
      @clippings
    end

    private

    def parse_metadata
      @raw_metadata.split("\r")[1..2].map(&:strip)
    end

    def build_clippings
      csv_hash = CSV.parse(@clipping_data, headers: true, col_sep: "\t").map(&:to_h)
      csv_hash.each{ |data| @clippings << format_clipping(data) }
    end

    def format_clipping(data)
      data[:book_title] = @book
      data[:author] = @authors
      data
    end
  end
end
