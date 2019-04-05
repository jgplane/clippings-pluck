module ClippingsPluck
  class Clipping < Hash
    def normalized_location
      self[:location].nil? ? nil : self[:location].normalize
    end
  end
end
