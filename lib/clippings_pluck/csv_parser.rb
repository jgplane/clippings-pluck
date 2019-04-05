module ClippingsPluck
  class CsvParser
    AMZN_DIVIDER = "----------------------------------------------\t\t\t\r\t\t\t\r"

    def initialize
      @clippings = Clippings.new
      @clipping = Clipping.new
    end

    def run(string)
      @raw_metadata, @clipping_data = string.split(AMZN_DIVIDER)
      @book, @authors = parse_metadata
      build_clippings
      @clippings
    end

    private

    def parse_metadata
      @raw_metadata.split("\r")[1..2].map(&:strip).map{ |line| line.gsub(/by /, "") }
    end

    def build_clippings
      csv_hash = CSV.parse(@clipping_data, headers: true, col_sep: "\t").map(&:to_h)
      csv_hash.each { |data| format_according_to_type(data) }
    end

    def format_according_to_type(data)
      if data['Annotation Type'] == 'Note'
        attach_note(data)
      else
        @clippings << format_clipping(data)
      end
    end

    def attach_note(data)
      if @clippings.last[:note].empty?
        @clippings.last[:note] = data['Annotation']
      else
        @clippings.last[:note] += " | #{data['Annotation']}"
      end
    end

    def format_clipping(data)
      data[:quote] = data.delete 'Annotation'
      location = (data.delete 'Location').gsub(/Location /, '')
      data[:location] = Location.new(location)
      data[:note] = ""
      data[:book_title] = @book
      data[:author] = @authors
      data.delete 'Annotation Type'
      data.delete 'Starred?'
      data
    end
  end
end
