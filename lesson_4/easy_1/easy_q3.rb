In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

small_car = Car.new
small_car.go_fast
# => I am a Car and going super fast!

A new Car object is instantiated on line 18. It belongs to the Car class. Because the Speed module is mixed in, Car objects have access to its methods. go_fast is called, and within it, a string is printed with a string interpolation #{self.class}. This self references the object, small_car, and the .class method returns the class of the small_car object, that being Car.