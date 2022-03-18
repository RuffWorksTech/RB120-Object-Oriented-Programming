require 'colorize'

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
  
  def add_one_score
    self.score += 1
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or Spock".yellow
      puts "(You may also enter 'r', 'p', 's', 'l', or 'sp', respectively)".yellow
      choice = gets.chomp.downcase
      choice = abbr_value(choice)
      break if Move::VALUES.include? choice
      puts "Sorry, that is an invalid choice."
    end

    self.move = Move.new(choice)
    puts '----------------------------------------------------------------'
  end

  def abbr_value(choice)
    value = ''
      case choice
      when 'r' then value = 'rock'
      when 'p' then value = 'paper'
      when 's' then value = 'scissors'
      when 'l' then value = 'lizard'
      when 'sp' then value = 'spock'
      end
      value
  end
end

class Computer < Player
  def set_name
    self.name = ['R2-D2', 'Hal', 'Chappie', 'Sonny'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?) ||
      (paper? && other_move.rock?) ||
      (paper? && other_move.spock?) ||
      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.paper?) ||
      (lizard? && other_move.spock?) ||
      (spock? && other_move.scissors?) ||
      (spock? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class RPSGame
  attr_accessor :human, :computer
  SCORE_TO_WIN = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock , #{human.name}!".light_yellow
    puts '----------------------------------------------------------------'
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!".light_yellow
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!".cyan.bold
      human.add_one_score
    elsif computer.move > human.move
      puts "#{computer.name} won!".cyan.bold
      computer.add_one_score
    else
      puts "It's a tie!".cyan.bold
    end
  end

  def display_scores
    puts "___________________________________".light_yellow
    puts "_______________SCORE_______________".light_yellow.on_black
    puts "#{human.name}: #{human.score}".light_yellow.on_black
    puts "#{computer.name}: #{computer.score}".light_yellow.on_black
  end

  def ultimate_winner?
    human.score == SCORE_TO_WIN || computer.score == SCORE_TO_WIN
  end

  def display_ultimate_winner
    winner = human.score == SCORE_TO_WIN ? human.name : computer.name
    puts "#{winner} is the ultimate winner!".light_yellow.on_red
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)".light_red
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be 'y' or 'n.'"
    end

    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_scores
      if ultimate_winner?
        display_ultimate_winner
        break
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
