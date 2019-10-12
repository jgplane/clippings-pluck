module ClippingsPluck
  class Clippings < Array
    def closest_highlight(note_location)
      sorted_notatables(note_location.normalize).last
    end

    def with_notes
      select(&:notated?)
    end

    def without_notes
      self - with_notes
    end

    private

    def sorted_notatables(location)
      notatables(location).sort_by(&:normalized_location)
    end

    def notatables(location)
      select { |clipping| clipping.notatable?(location) }
    end
  end
end
