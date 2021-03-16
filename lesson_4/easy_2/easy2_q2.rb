# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future

# - The result will be the same as in the previous example. There is no .predict_the_future method in the RoadTrip class, so the Oracle class is consulted next. The .predict_the_future method is found and executed. Within it, the choices method is called. Due to the method lookup structure, the RoadTrip class is checked first for a .choices method because it is still the implicit caller. One is found, so a random choice from the returned array is concatenated to "You will ".