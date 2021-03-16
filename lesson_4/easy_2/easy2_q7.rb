# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# - The @@cats_count is a class variable that is scoped within the class. It does not belong to any one instance of the class, but instead the class itself. It is built to track attributes that pertain to the class as a whole.

Cat.new('tabby')
Cat.new('white')
p Cat.cats_count == 2