require 'spec_helper'

def check_width_height(svg, width, height)
    svg.width.should    == width
    svg.height.should   == height
end

describe RubySVGLight do
  it "Check width calculations, objects from origin" do
    canvas = RubySVGLight::Document.new()
    check_width_height(canvas, 0, 0)

    canvas.rectangle x: 0, y: 0, width: 10, height: 20
    check_width_height(canvas, 10, 20)

    canvas.line x: 0, y: 0, width: 30, height: 40
    check_width_height(canvas, 30, 40)

    canvas.circle x: 0, y: 0, r: 100
    check_width_height(canvas, 100, 100)

    canvas.ellipse x: 0, y: 0, width: 300, height: 400
    check_width_height(canvas, 150, 200)
  end

  it "Smaller new component should not shrink size" do
    canvas = RubySVGLight::Document.new()
    canvas.circle x: 0, y: 0, r: 100
    check_width_height(canvas, 100, 100)

    canvas.circle x: 0, y: 0, r: 50
    check_width_height(canvas, 100, 100)

    canvas.line x: 0, y: 0, width: 60, height: 40
    check_width_height(canvas, 100, 100)

    canvas.rectangle x: 0, y: 0, width: 10, height: 20
    check_width_height(canvas, 100, 100)

    canvas.ellipse x: 0, y: 0, width: 10, height: 20
    check_width_height(canvas, 100, 100)
  end

  it "Check width calculations, objects not on origin" do
    canvas = RubySVGLight::Document.new()
    check_width_height(canvas, 0, 0)

    canvas.rectangle x: 15, y: 25, width: 10, height: 20
    check_width_height(canvas, 25, 45)

    canvas.line x: 35, y: 45, width: 30, height: 40
    check_width_height(canvas, 65, 85)

    canvas.circle x: 10, y: 15, r: 100
    check_width_height(canvas, 110, 115)

    canvas.ellipse x: 100, y: 200, width: 30, height: 50
    check_width_height(canvas, 115, 225)
  end
end


