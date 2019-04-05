module ClippingsPluck
  class Clipping < Hash
    def location=(location)
      self[:location] = Location.new(location)
    end

    def normalized_location
      missing_location? ? nil : self[:location].normalize
    end

    def eligible_for_note_attachment?(note_location)
      has_location? && normalized_location <= note_location
    end

    def notated?
      !self[:note].nil?
    end

    def missing_location?
      self[:location].nil?
    end

    def has_location?
      !missing_location?
    end
  end
end
