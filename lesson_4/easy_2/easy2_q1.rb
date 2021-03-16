# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future

# - The .predict_the_future method is called on the oracle object. The predict_the_future returns a string concatenated from "You will " and a random element from the array returned by the .choices method.