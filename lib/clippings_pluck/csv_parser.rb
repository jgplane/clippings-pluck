require 'csv'

module ClippingsPluck
  class CsvParser
    AMZN_DIVIDER = "----------------------------------------------\t\t\t\r\t\t\t\r"
    ALT_AMZN_DIVIDER = "----------------------------------------------"

    def initialize
      @clippings = Clippings.new
    end

    def run(string)
      @raw_metadata, @clipping_data = string.split(AMZN_DIVIDER)
      if @clipping_data.nil?
        @raw_metadata, @clipping_data = string.split(ALT_AMZN_DIVIDER)
      end
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
        @clipping = Clipping.new
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
      @clipping[:quote] = data.delete 'Annotation'
      @clipping.location = (data.delete 'Location').gsub(/Location /, '')
      @clipping[:note] = ""
      @clipping[:book_title] = @book
      @clipping[:author] = @authors
      data.delete 'Annotation Type'
      data.delete 'Starred?'
      @clipping
    end
  end
end
