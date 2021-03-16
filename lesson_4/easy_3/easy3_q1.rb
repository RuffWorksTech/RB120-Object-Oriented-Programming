class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:
hello = Hello.new
hello.hi
# => prints "Hello"


# case 2:
hello = Hello.new
hello.bye
# => NoMethodError


# case 3:
hello = Hello.new
hello.greet
# => ArgumentError (0 for 1)


# case 4:
hello = Hello.new
hello.greet("Goodbye")
# => prints "Goodbye"


# case 5:
Hello.hi
# NoMethod error