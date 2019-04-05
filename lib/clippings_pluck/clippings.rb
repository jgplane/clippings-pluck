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
      reject { |clipping| ineligible?(clipping, location) }
    end

    def ineligible?(clipping, location)
      clipping[:location].nil? || clipping.normalized_location > location
    end
  end
end
