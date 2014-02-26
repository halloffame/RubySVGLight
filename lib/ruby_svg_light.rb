module RubySVGLight
  VERSION = '0.1.0'

  require 'ruby_svg_light/document'
  require 'ruby_svg_light/element'

  # require all elements files
  Dir[File.dirname(__FILE__) + '/ruby_svg_light/elements/*.rb'].each {|file| require file }
end
