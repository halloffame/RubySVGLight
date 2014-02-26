module RubySVGLight
  class Circle < Element
    def initialize(opts={})
      super(opts)

      @tag_name = 'circle'

      set_center
      set_radius
    end


    # Bounds needed to resize the parent SVG element
    def bounds
      { x: @attrs[:cx] + @attrs[:r], y: @attrs[:cy] + @attrs[:r] }
    end

  private

    def set_center
      @attrs[:cx] ||= @attrs[:x] || 0
      @attrs[:cy] ||= @attrs[:y] || 0
      @attrs[:x] = nil
      @attrs[:y] = nil
    end

    def set_radius
      @attrs[:r] ||= @attrs[:radius] || 10
      @attrs[:radius] = nil
    end

  end
end