module RubySVGLight
  class Text < Element
    def initialize(content, opts={})
      super(opts)

      @tag_name = 'text'
      @content  = content

      @attrs[:stroke] = opts[:stroke] || ''
      @attrs[:stroke_width] = opts[:stroke_width] || '0'
      @attrs[:fill] = opts[:fill] || '#000'
      @attrs[:font_family] ||= "sans-serif"
      @attrs[:font_size] ||= '24px'

      center_vertically
    end


    # Bounds needed to resize the parent SVG element
    def bounds
      { x: @attrs[:x], y: @attrs[:y] + @attrs[:font_size].to_i }
    end

  private

    def center_vertically
      if @attrs[:center_vertically]
        @attrs[:dominant_baseline] = 'central'
        @attrs[:center_vertically] = nil
      end
    end

  end
end