require 'csv'

module ClippingsPluck
  class CsvParser
    EXCEL_DIVIDER = "----------------------------------------------\t\t\t\r\t\t\t\r"
    EXCEL_SEP = "\t"

    AMZN_DIVIDER = "----------------------------------------------"
    AMZN_SEP = ","

    def initialize
      @clippings = Clippings.new
    end

    def run(string)
      @string = string
      @raw_metadata, @clipping_data = @string.split(divider)
      @book, @authors = parse_metadata
      build_clippings
      @clippings
    end

    private

    def excel?
      @string.include? EXCEL_DIVIDER
    end

    def divider
      excel? ? EXCEL_DIVIDER : AMZN_DIVIDER
    end

    def sep
      excel? ? EXCEL_SEP : AMZN_SEP
    end

    def parse_metadata
      metadata = @raw_metadata.split("\r")[1..2].map(&:strip).map{ |line| line.gsub(/by /, "") }
      metadata.map! { |string| string.gsub("\"", "").gsub(",,,", "") } if !excel?
      metadata
    end

    def build_clippings
      remove_ghost_rows if !excel?
      csv_hash = CSV.parse(@clipping_data, headers: true, col_sep: sep).map(&:to_h)
      csv_hash.each { |data| format_according_to_type(data) }
    end

    def remove_ghost_rows
      @clipping_data = @clipping_data.gsub(",,,\r\n,,,\r\n", "")
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
