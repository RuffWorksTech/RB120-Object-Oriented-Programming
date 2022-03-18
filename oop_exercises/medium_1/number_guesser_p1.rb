# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

class GuessingGame
  def initialize(low_limit, up_limit)
    @rand_num = rand(low_limit..up_limit)
    @num_guesses = Math.log2(up_limit - low_limit).to_i + 1
    @low_limit = low_limit
    @up_limit = up_limit
  end

  def play
    result = nil
    @num_guesses.downto(1) do |n|
      puts n == 1 ? "You have #{n} guess remaining." : "You have #{n} guesses remaining."
      result = check_guess(prompt_guess)
      display_guess_result(result)
      break if result == :match
    end

    puts win_or_lose(result)
  end

  private

  def prompt_guess
    guess = nil
    loop do
      print "Enter a number between #{@low_limit} and #{@up_limit}: "
      guess = gets.chomp.to_i
      return guess if (@low_limit..@up_limit).cover?(guess)
      print "Invalid guess. "
    end
  end

  def display_guess_result(guess)
    case guess
    when :match then puts "That's the number!"
    when :low then puts "Your guess is too low."
    when :high then puts "Your guess is too high."
    end
    puts ""
  end

  def check_guess(guess)
    return :match if guess == @rand_num
    return :low if guess < @rand_num
    :high
  end

  def win_or_lose(result)
    result == :match ? "You won!" : "The number was #{@rand_num} and you have no more guesses. You lost!"
  end
end

game = GuessingGame.new(501, 1500)
game.play