# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def information
    "I want to turn on the light with a brightness level of #{@brightness} and a color #{color}"
  end

end

light = Light.new('high', 'green')
p light.information