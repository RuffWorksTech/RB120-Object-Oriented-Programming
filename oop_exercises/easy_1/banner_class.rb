# Behold this incomplete class for constructing boxed banners. Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

# You may assume that the input will always fit in your terminal window.

class Banner
  def initialize(message, width = message.length)
    @message = message
    if width < message.length || width > 100
      puts "Banner width invalid. Please use a number greater than or equal to #{message.length} or less than 101."
      @width = message.length
    else
      @width = width
    end
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @width}-+"
  end

  def empty_line
    "| #{' ' * @width} |"
  end

  def message_line
    "| #{@message.center(@width)} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 41)
puts banner

banner = Banner.new('', 14)
puts banner