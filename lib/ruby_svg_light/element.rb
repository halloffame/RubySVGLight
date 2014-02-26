module RubySVGLight
  class Element
    def initialize(opts={})
      @tag_name = 'override'
      @content = nil

      @attrs                    = opts.dup
      @attrs[:stroke]         ||= '#000'
      @attrs[:stroke_width]   ||= 1
    end


    def attr_to_s(attr_name, attr_val)
      if attr_val.nil? || attr_val.to_s.empty?
        return nil
      else
        "#{attr_name.to_s.tr('_', '-')}=\"#{attr_val}\""
      end
    end

    def attrs_to_s
      @attrs.map{|k,v| attr_to_s(k,v) }.compact.join(' ')
    end

    def to_s
      if @content
        "<#{@tag_name} #{attrs_to_s}>#{@content}</#{@tag_name}>"
      else
        "<#{@tag_name} #{attrs_to_s} />"
      end
    end

    # OVERWRITE THIS METHOD
    # Bounds needed to resize the parent SVG element
    def bounds
      { x: 0, y: 0 }
    end

  end
end