require_relative "clippings"

module ClippingsPluck
  class TxtParser
    def initialize
      @clippings = Clippings.new
      @clipping = {}
    end

    def run(file_content)
      split_clippings(file_content)
      @clippings
    end

    private

    def split_clippings(file_content)
      clippings = file_content.force_encoding("UTF-8").split("=" * 10).delete_if { |c| c.strip.empty? }
      clippings.each { |clipping| parse_lines(clipping) }
    end

    def parse_lines(clipping)
      lines = clipping.lines.delete_if { |line| line.strip.empty? }.collect(&:strip)
      parse_type(lines) if lines.length == 3
    end

    def parse_type(lines)
      parse_quote(lines) if lines[1].include? "Highlight"
      parse_note(lines) if lines[1].include? "Note"
    end

    def parse_note(lines)
      @clippings[-1][:note] = lines[2] if @clippings.length.positive?
    end

    def parse_quote(lines)
      @clipping[:note] = nil
      @clipping[:quote] = lines[2]
      parse_author(lines)
    end

    def parse_author(lines)
      author_names = lines[0].reverse[/\).*?\(/].to_s.gsub(/[()]/, "").reverse
      if author_names.include? ","
        last_name, first_name = author_names.split(",").collect(&:strip)
      else
        first_name, last_name = author_names.split(" ", 2).collect(&:strip)
      end
      @clipping[:author] = first_name + ' ' + last_name
      lines[0].slice!("(#{author_names})")
      parse_book(lines)
    end

    def parse_book(lines)
      @clipping[:book_title] = lines[0].strip
      parse_page(lines)
    end

    def parse_page(lines)
      page = lines[1].match(/(?<=page ).\d*/)
      @clipping[:page] = page.nil? ? nil : page[0].to_i
      parse_location(lines)
    end

    def parse_location(lines)
      location = lines[1].match(/(?<=Location ).\S*/)
      @clipping[:location] = location.nil? ? nil : location[0]
      parse_date(lines)
    end

    def parse_date(lines)
      date = lines[1].match(/(?<=Added on ).+/)
      @clipping[:date] = date.nil? ? nil : date[0]
      push_clipping
    end

    def push_clipping
      @clippings << @clipping
      @clipping = {}
    end
  end
end
