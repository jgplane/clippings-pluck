module ClippingsPluck
  class Clipping < Hash
    def location=(location)
      self[:location] = Location.new(location)
    end

    def normalized_location
      locatable? ? self[:location].normalize : nil
    end

    def notatable?(note_location)
      locatable? && normalized_location <= note_location
    end

    def notated?
      !self[:note].nil?
    end

    private

    def locatable?
      !self[:location].nil?
    end
  end
end
