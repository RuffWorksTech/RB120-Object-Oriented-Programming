=begin
Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves: rock, paper, or scissors. The chose moves will then be compared to see who wins according to the following rules:

- Rock beats Scissors
- Scissors beats Paper
- Paper beats Rock

If the players chose the same move, then it's a tie.

Nouns: player, move rules
Verbs: choose, compare

Player
  - choose
Move
Rule

  - compare

=end

require 'pry'

SCORE_TO_WIN = 3

class Rock
  @@value = 'rock'
  @@beats = %w(scissors lizard)
  
  def self.value
    @@value
  end
  
  def self.beats
    @@beats
  end
end

class Paper
  @@value = 'paper'
  @@beats = %w(rock spock)
  
  def self.value
    @@value
  end
  
  def self.beats
    @@beats
  end
end

class Scissors
  @@value = 'scissors'
  @@beats = %w(lizard paper)
  
  def self.value
    @@value
  end
  
  def self.beats
    @@beats
  end
end

class Lizard
  @@value = 'lizard'
  @@beats = %w(paper spock)
  
  def self.value
    @@value
  end
  
  def self.beats
    @@beats
  end
end

class Spock
  @@value = 'spock'
  @@beats = %w(rock scissors)
  
  def self.value
    @@value
  end
  
  def self.beats
    @@beats
  end
end

class Move
  attr_reader :value
  
  VALUES = %w(r rock p paper sc scissors l lizard sp spock)

  def initialize(value)
    @value = case value
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 'sc' then 'scissors'
    when 'l' then 'lizard'
    when 'sp' then 'spock'
    else value
    end
  end

  # def >(other_move)
  #   (rock? && other_move.scissors? || other_move.lizard?) ||
  #   (paper? && other_move.rock? || other_move.spock?) ||
  #   (scissors? && other_move.paper? || other_move.lizard?) ||
  #   (lizard? && other_move.spock? || other_move.paper?) ||
  #   (spock? && other_move.rock? || other_move.scissors?)
  # end

  def rock?
    @value == Rock::value
  end

  def paper?
    @value == Paper::value
  end
  
  def scissors?
    @value == Scissors::value
  end
  
  def lizard?
    @value == Lizard::value
  end
  
  def spock?
    @value == Spock::value
  end

  def >(other_move)
    # binding.pry
    rock? && Rock::beats.include?(other_move.value) ||
    paper? && Paper::beats.include?(other_move.value) ||
    scissors? && Scissors::beats.include?(other_move.value) ||
    lizard? && Lizard::beats.include?(other_move.value) ||
    spock? && Spock::beats.include?(other_move.value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :moves

  def initialize
    set_name
    @score = 0
    @moves = []
  end
  
  def record_move(move)
    @moves << move
  end
  
  def print_moves
    puts "Your moves were #{@moves.join(', ')}."
  end
  
  def score_point
    @score += 1
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock (or 'r'), paper (or 'p'), scissors (or 'sc'), lizard (or 'l'), or spock (or 'sp')."
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny Number5).sample
  end

  def choose
    self.move = case @name
    when 'R2D2' then Move.new('rock')
    when 'Hal'
      Move.new(%w(scissors scissors scissors scissors scissors scissors rock).sample)
    when 'Chappie' then Move.new('scissors')
    when 'Sonny' then Move.new('paper')
    when 'Number5' then Move.new(Move::VALUES.sample)
    end
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    puts "- The first player to reach #{SCORE_TO_WIN} points is the grand winner."
    puts "\n"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def record_moves
    human.record_move(human.move)
    computer.record_move(computer.move)
  end

  def display_moves
    puts " - #{human.name} chose #{human.move}."
    puts " - #{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score_point
    elsif computer.move > human.move
      puts "#{computer.name} won!"
      computer.score_point
    else puts "It's a tie!"
    end
  end

  def display_points
    puts "Score: #{human.name}: #{human.score}  |  #{computer.name}: #{computer.score}"
    puts "-----------------------------------------------------------------------------------------------------"
  end

  def grand_winner?
    human.score == SCORE_TO_WIN || computer.score == SCORE_TO_WIN
  end

  def display_grand_winner
    puts "#{human.name} is the grand winner with #{human.score} points!" if human.score == SCORE_TO_WIN
    puts "#{computer.name} is the grand winner with #{computer.score} points!" if computer.score == SCORE_TO_WIN
  end

  def display_move_lists
    puts "- #{human.name}'s moves were: #{human.moves.join(', ')}."
    puts "- #{computer.name}'s moves were: #{computer.moves.join(', ')}."
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts "Sorry, must be 'y' or 'n'."
    end

    return true if answer == 'y'
    false
  end

  def play
    display_welcome_message

    loop do
      loop do
        human.choose
        computer.choose
        record_moves
        display_moves
        display_winner
        display_points
        break if grand_winner?
      end
      display_grand_winner if grand_winner?
      display_move_lists
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play