module RubySVGLight
  class Rectangle < Element
    def initialize(opts={})
      super(opts)

      @tag_name = 'rect'
    end

    # Bounds needed to resize the parent SVG element
    def bounds
      { x: @attrs[:x] + @attrs[:width], y: @attrs[:y] + @attrs[:height] }
    end

  end
end