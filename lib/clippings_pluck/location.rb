module ClippingsPluck
  class Location < String
    def normalize
      range? ? highest_of_range : self
    end

    private

    def range?
      include?("-")
    end

    def highest_of_range
      split("-").last
    end
  end
end

