require 'spec_helper'

def style_contains( format )
  /style=\"(.*;)* ?#{format};(.*;)* ?\"/m
end

describe RubySVGLight do

  #Hooks
  before( :each ) do
    @canvas = RubySVGLight::Document.new()
    # 10 Random characters for test string changes for each test
    @text = (0...10).map{ (('A'..'Z').to_a + ('a'..'z').to_a)[rand(52)] }.join
  end

  after( :each ) do
    #Verify that actual text was included regardless of options used
    @canvas.to_s.should include ">#{@text}</text>"
  end





  #Tests
  it "Text, default font size" do
    @canvas.text @text, x: 0, y: 0

    @canvas.to_s.should include %{font-size="24px"}
  end

  it "Text, set fontsize with local option" do
    @canvas.text @text, x: 0, y: 0, font_size: '100px'

    @canvas.to_s.should include %{font-size="100px"}
  end


  # The 4 ways to vertically centre text
  it "Text, Vertical centre with :center_vertically" do
    @canvas.text @text, x: 0, y: 0, center_vertically: true

    @canvas.to_s.should match %{dominant-baseline="central"}
  end





  # The 4 ways to horizontally centre text
  it "Text, Left align with :text_anchor" do
    @canvas.text @text, x: 0, y: 0, text_anchor: 'start'

    @canvas.to_s.should match %{text-anchor="start"}
  end

  it "Text, Center align with :text_anchor" do
    @canvas.text @text, x: 0, y: 0, text_anchor: 'middle'

    @canvas.to_s.should match %{text-anchor="middle"}
  end
  it "Text, Rign align with :text_anchor" do
    @canvas.text @text, x: 0, y: 0, text_anchor: 'end'

    @canvas.to_s.should match %{text-anchor="end"}
  end




  #Vertical and Horizontal centre text
  it "Text, Horizintal and Vertical centre with :center_vertically" do
    @canvas.text @text, x: 0, y: 0, center_vertically: true, text_anchor: 'middle'

    @canvas.to_s.should match %{dominant-baseline="central"}
    @canvas.to_s.should match %{text-anchor="middle"}
  end


end


