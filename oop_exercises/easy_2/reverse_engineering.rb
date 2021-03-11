# Write a class that will display:

# => ABC
# => xyz


class Transform
  def initialize(input)
    @input = input
  end
  
  def uppercase
    @input.upcase
  end
  
  def self.lowercase(str)
    str.downcase
  end
  
end



# When the following code is run:

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')