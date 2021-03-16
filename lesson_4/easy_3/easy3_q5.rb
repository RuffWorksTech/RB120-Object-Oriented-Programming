# If I have the following class, what would happen if I called the methods like shown below?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
# => NoMethodError

tv.model
# => model execution

Television.manufacturer
# => manufacturer method execution

Television.model
# => NoMethodError