# 1. Add a class method to your MyCar class that calculates the gas mileage of any car.

# 2. Override the to_s method to create a user friendly print out of your object.

# class MyCar
#   attr_accessor :color, :make, :model
#   attr_reader :year
  
#   def initialize(y, c, make, model)
#     @year = y
#     @color = c
#     self.make = make
#     @model = model
#   end
 
#   def self.mileage(gal, miles)
#     puts "#{miles / gal} miles per gallon of gas."
#   end

#   def to_s
#     "Your car is a #{color} #{year} #{make} #{model}."
#   end
# end

# qx = MyCar.new(2016, 'white', 'Infiniti', 'QX60')
# puts qx


# 3. When running the following code...

class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
end

bob = Person.new("Steve")
bob.name = "Bob"

# We get the following error...
# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
  
# Why do we get this error and how do we fix it?