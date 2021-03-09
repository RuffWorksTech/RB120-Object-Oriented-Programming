# 1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

# class MyCar
#   attr_accessor :color, :model
#   attr_reader :year
  
#   def initialize(y, c, m)
#     @year = y
#     @color = c
#     @model = m
#     @current_speed = 0
#   end
  
#   def speed_up(num)
#     @current_speed += num
#     puts "You are now going #{@current_speed} MPH."
#   end
  
#   def brake(num)
#     @current_speed -= num
#     puts "You are now going #{@current_speed} MPH."
#   end
  
#   def shut_off
#     @current_speed = 0
#     puts "You turn the car off."
#   end

#   def spray_paint(new_color)
#     self.color = new_color
#     puts "Did you really just spray paint your car #{new_color}?... Alright......"
#   end

# end

# qx = MyCar.new(2016, 'white', 'QX60')
# qx.spray_paint('black')