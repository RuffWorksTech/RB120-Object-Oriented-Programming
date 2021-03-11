# Consider the following classes. Refactor these classes so they all use a common superclass, and inherit behavior as needed.

class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

car = Car.new("Infiniti", "QX60")
puts car

bike = Motorcycle.new("Honda", "Shadow")
puts bike

truck = Truck.new("Ford", "F-350", "30000")
puts truck