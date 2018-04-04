module ClippingsPluck
  class Clippings < Array
    def with_notes
      self.reject{ |clipping| clipping[:note].nil? }
    end

    def without_notes
      self - with_notes
    end
  end
end
