module RubySVGLight
  class Ellipse < Element
    def initialize(opts={})
      super(opts)

      @tag_name = 'ellipse'

      set_center
      set_width
      set_height
    end


    # Bounds needed to resize the parent SVG element
    def bounds
      { x: @attrs[:cx] + @attrs[:rx], y: @attrs[:cy] + @attrs[:ry] }
    end


  private

    def set_center
      @attrs[:cx] ||= @attrs[:x] || 0
      @attrs[:cy] ||= @attrs[:y] || 0
      @attrs[:x] = nil
      @attrs[:y] = nil
    end

    def set_width
      if @attrs[:width]
        @attrs[:rx] ||= @attrs[:width] / 2
        @attrs[:width] = nil
      end
    end

    def set_height
      if @attrs[:height]
        @attrs[:ry] = @attrs[:height] / 2
        @attrs[:height] = nil
      end
    end

  end
end