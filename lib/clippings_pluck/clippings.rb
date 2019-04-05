module ClippingsPluck
  class Clippings < Array
    def closest_highlight(note_location)
      sorted_eligible_note_matches(note_location.normalize).first
    end

    def with_notes
      reject { |clipping| clipping[:note].nil? }
    end

    def without_notes
      self - with_notes
    end

    private

    def sorted_eligible_note_matches(location)
      eligible_note_matches(location).sort do |a, b|
        b.normalized_location <=> a.normalized_location
      end
    end

    def eligible_note_matches(location)
      select { |clipping| clipping.eligible_for_note_attachment?(location) }
    end
  end
end
