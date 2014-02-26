module RubySVGLight
  class Line < Element
    def initialize(opts={})
      super(opts)

      @tag_name = 'line'

      set_var_1
      set_width
      set_height
      set_var_2
    end


    # Bounds needed to resize the parent SVG element
    def bounds
      { x: [@attrs[:x1], @attrs[:x2]].max, y: [@attrs[:y1], @attrs[:y2]].max }
    end

  private

    def set_var_1
      @attrs[:x1] ||= @attrs[:x]
      @attrs[:y1] ||= @attrs[:y]
      @attrs[:x] = nil
      @attrs[:y] = nil
    end

    def set_width
      if @attrs[:width] && @attrs[:x1]
        @attrs[:x2] = @attrs[:x1] + @attrs[:width]
        @attrs[:width] = nil
      end
    end

    def set_height
      if @attrs[:height] && @attrs[:y1]
        @attrs[:y2] = @attrs[:y1] + @attrs[:height]
        @attrs[:height] = nil
      end
    end

    def set_var_2
      @attrs[:x2] ||= @attrs[:x1]
      @attrs[:y2] ||= @attrs[:y1]
    end

  end
end