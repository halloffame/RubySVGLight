module RubySVGLight
  class Document
    attr_reader :body, :width, :height

    def self.generate(filename, options={}, &block)
      pdf = new(options, &block)
      pdf.render_file(filename)
    end

    def initialize(options={}, &block)
      @options                  = options.dup
      @options[:width]        ||= :auto
      @options[:height]       ||= :auto

      @width  = 0
      @height = 0
      @body   = []

      # Handle implicit or explicit blocks when required.
      if block_given?
        if block.arity == 1
          yield self
        else
          instance_eval &block
        end
      end
    end


    #Add render_file method like prawn
    def render_file(filename)
      to_file(filename)
    end

    def header
      text = %{<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="100%" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg">
}
    end

    def footer
      text = %{\n</svg>}
    end

    ## Drawing methodds
    def circle(opts={})
      obj = RubySVGLight::Circle.new(opts)
      update_size(obj.bounds)
      @body << obj.to_s
    end

    def line(opts={})
      obj = RubySVGLight::Line.new(opts)
      update_size(obj.bounds)
      @body << obj.to_s
    end

    def rectangle(opts={})
      obj = RubySVGLight::Rectangle.new(opts)
      update_size(obj.bounds)
      @body << obj.to_s
    end

    def ellipse(opts={})
      obj = RubySVGLight::Ellipse.new(opts)
      update_size(obj.bounds)
      @body << obj.to_s
    end

    def text(input_text, opts={})
      obj = RubySVGLight::Text.new(input_text, opts)
      update_size(obj.bounds)
      @body << obj.to_s
    end

    def options(opts={})
      @options.merge! opts
    end

    def height
      @options[:height] == :auto ? @height : @options[:height]
    end

    def width
      @options[:width] == :auto ? @width : @options[:width]
    end

    def components_only_to_s
      @body.join
    end

    # To string includes header and footers
    def to_s
      self.header + '  ' + @body.join("\n  ") + self.footer
    end

    # to_file includes header and footers for a complete svg file
    def to_file(filename)
      File.open(filename, 'w') do |f|
        f.puts self.header
        @body.each { |section| f.puts section }
        f.puts self.footer
      end
    end


  private

    ### I'm not opposed to global options, but they should probably be scoped by shape or something,
    ###  this will help from things like font_size being printed on lines and rects, etc...
    ### For now I am just disabling it.
    #
    # def relavant_shape_options
    #   opts = @options.dup
    #   opts.keys.each { |key| delete(key) }
    #   opts
    # end

    # # Private method, for allowing overide options (without actually overwriting @options)
    # def calc_local_options(opts={})
    #   @options.merge opts
    # end

    #Internal helper function for updating dimensions
    def update_size(bounds)
      @width  = bounds[:x] if bounds[:x] > @width
      @height = bounds[:y] if bounds[:y] > @height
    end

  end
end



if $0 == __FILE__
  filename = 'test.svg'

  a = RubySVGLight::Document.new()
  a.circle(20,10,10)
  a.to_file( filename )

  puts "Created #{filename}"
end
