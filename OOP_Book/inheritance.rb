# 1. Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

# class Vehicle
#   attr_accessor :color, :make, :model
#   attr_reader :year

#   def initialize(y, c, make, model)
#     @year = y
#     self.color = c
#     self.make = make
#     self.model = model
#   end

#   def info
#     "Your car is a #{color} #{year} #{make} #{model}."
#   end
# end

# class MyCar < Vehicle
#   SEDAN = true
# end

# class MyTruck < Vehicle
#   TRUCK = true
# end

# qx = MyCar.new(2016, 'white', 'Infiniti', 'QX60')
# puts qx.info
# f150 = MyTruck.new(2017, 'white', 'Ford', 'F-150')
# puts f150.info
# ---------------------------------------------------------------------------------------------------------------------------

# 2. Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.

# class Vehicle
#   attr_accessor :color, :make, :model
#   attr_reader :year
  
#   @@num_of_vehicles = 0
  
#   def initialize(y, c, make, model)
#     @year = y
#     self.color = c
#     self.make = make
#     self.model = model
#     @@num_of_vehicles += 1
#   end
  
#   def self.print_total_vehicles
#     puts "This program has created #{@@num_of_vehicles} vehicles."
#   end
  
#   def info
#     "Your car is a #{color} #{year} #{make} #{model}."
#   end
# end

# class MyCar < Vehicle
#   SEDAN = true
# end

# class MyTruck < Vehicle
#   TRUCK = true
# end

# qx = MyCar.new(2016, 'white', 'Infiniti', 'QX60')
# puts qx.info
# f150 = MyTruck.new(2017, 'white', 'Ford', 'F-150')
# puts f150.info
# Vehicle.print_total_vehicles
# ---------------------------------------------------------------------------------------------------------------------------

# 3. Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

# module Truckable
#   def has_bed?(bed)
#     bed ? "has_bed" : "don't have no bed"
#   end
# end

# class Vehicle
#   attr_accessor :color, :make, :model
#   attr_reader :year
  
#   @@num_of_vehicles = 0
  
#   def initialize(y, c, make, model)
#     @year = y
#     self.color = c
#     self.make = make
#     self.model = model
#     @@num_of_vehicles += 1
#   end

#   private 

#   def age
#     "Your #{model} is #{Time.now.year - @year} year(s) old."
#   end
  
#   def self.print_total_vehicles
#     puts "This program has created #{@@num_of_vehicles} vehicles."
#   end

#   protected
  
#   def to_s
#     "This is a #{color} #{year} #{make} #{model}."
#   end
# end

# class MyCar < Vehicle
#   SEDAN = true
# end

# class MyTruck < Vehicle
#   include Truckable
#   TRUCK = true
# end

# qx = MyCar.new(2016, 'white', 'Infiniti', 'QX60')
# puts qx
# puts qx.age
# f150 = MyTruck.new(2017, 'white', 'Ford', 'F-150')
# puts f150
# puts f150.age
# Vehicle.print_total_vehicles
# ---------------------------------------------------------------------------------------------------

# 7. Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end
  
#   def better_grade_than?(student)
#     @grade > student.grade
#   end
  
#   protected
  
#   def grade
#     @grade
#   end
  
# end

# joe = Student.new('joe', 92)
# bob = Student.new('bob', 89)
# puts "Well done!" if joe.better_grade_than?(bob)
# ----------------------------------------------------------------------------------------------------------

# 8. Given the following code...

# bob = Person.new
# bob.hi

# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?

class Person
  private
  def hi
    "Hello"
  end
end

bob = Person.new
bob.hi

# The `hi` instance method is private. In order to be able to access it, you must make it non-private (move above `private` method)