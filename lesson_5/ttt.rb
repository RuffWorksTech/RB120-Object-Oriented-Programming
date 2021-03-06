class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "       |       |"
    puts "   #{@squares[1]}   |   #{@squares[2]}   |   #{@squares[3]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@squares[4]}   |   #{@squares[5]}   |   #{@squares[6]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@squares[7]}   |   #{@squares[8]}   |   #{@squares[9]}"
    puts "       |       |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def full?
    unmarked_keys.empty?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Layout/LineLength
  def find_at_risk_square(line, marker)
    squares = @squares.values_at(*line)
    @squares.key(squares.select(&:unmarked?).first) if squares.select { |square| square.marker == marker }.count == 2
  end
  # rubocop:enable Layout/LineLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def marked?
    @marker != INITIAL_MARKER
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_accessor :marker, :name
  attr_reader :score

  def initialize(marker)
    @marker = TTTGame::COMPUTER_MARKER if marker == :computer
    @name = ''
    @score = 0
  end

  def add_one_to_score
    @score += 1
  end
end

class TTTGame
  # Modify to 'player', 'computer', or 'choose'
  FIRST_TO_MOVE = 'player'
  SCORE_TO_WIN = 2
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(:human)
    @computer = Player.new(:computer)
    @current_player = ''
  end

  def play
    clear
    display_welcome_message
    set_names
    set_player_marker
    main_game
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "Score to be the grand winner: #{SCORE_TO_WIN}"
    puts ""
  end

  # rubocop:disable Metrics/MethodLength
  def choose_starting_player
    if FIRST_TO_MOVE == 'choose'
      player_to_start = nil
      loop do
        puts "Who should go first? (enter 'p' for player, 'c' for computer)"
        player_to_start = gets.chomp.downcase
        break if %w(p c).include? player_to_start
        puts "Sorry, must be 'p' or 'c'."
      end
    else
      player_to_start = FIRST_TO_MOVE
    end
    player_to_start
  end

  def set_starting_player
    case choose_starting_player
    when /^p/
      @current_player = human.marker
      @first_to_move = human.marker
    when /^c/
      @current_player = computer.marker
      @first_to_move = computer.marker
    end
    clear
  end

  def prompt_player_marker
    player_marker = nil
    loop do
      puts "Type any character to be your marker (must be one character only):"
      player_marker = gets.chomp.downcase
      break if player_marker.length == 1
      puts "Sorry, you can only enter one character."
    end
    player_marker
  end

  def set_player_marker
    human.marker = prompt_player_marker
  end

  def prompt_player_name
    player_name = nil
    loop do
      puts "Enter your name:"
      player_name = gets.chomp
      break if !player_name.empty?
      puts "Sorry, you must enter at least something..."
    end
    player_name
  end

  def set_player_name
    human.name = prompt_player_name
  end

  def set_computer_name
    computer.name = %w(R2D2 C-3PO Data Goddard WALL-E Optimus).sample
  end

  def set_names
    set_player_name
    set_computer_name
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye."
  end

  def main_game
    set_starting_player
    loop do
      display_board
      players_move
      increase_scores
      display_result
      break if grand_winner?
      break unless play_again?
      reset
    end
    display_grand_winner if human.score > 0 || computer.score > 0
  end

  # rubocop:disable Layout/LineLength
  def display_board
    puts "#{human.name}'s marker: '#{human.marker}'  |  #{computer.name}'s marker: '#{computer.marker}'"
    puts ""
    board.draw
    puts ""
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr, dilimiter = ', ', word = 'or')
    case arr.size
    when 1 then arr.join
    when 2 then arr.join(" #{word} ")
    else
      "#{arr[0..-2].join(dilimiter) + dilimiter + word} #{arr.last}"
    end
  end

  def human_moves
    puts "Choose a square between (#{joinor(board.unmarked_keys)}):"

    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    choice = nil

    # Offense
    Board::WINNING_LINES.each do |line|
      choice = board.find_at_risk_square(line, computer.marker)
      break if choice
    end

    # Defense
    Board::WINNING_LINES.each do |line|
      choice = board.find_at_risk_square(line, human.marker)
      break if choice
    end

    # Choose square 5
    choice = 5 if board.unmarked_keys.include?(5)

    # Random square
    choice = board.unmarked_keys.sample if !choice

    board[choice] = computer.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = computer.marker
    else
      computer_moves
      @current_player = human.marker
    end
  end

  def human_turn?
    @current_player == human.marker
  end

  def increase_scores
    case board.winning_marker
    when human.marker then human.add_one_to_score
    when computer.marker then computer.add_one_to_score
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker then puts "#{human.name} won!"
    when computer.marker then puts "#{computer.name} won!"
    else puts "It's a tie!"
    end
    display_scores
  end
  # rubocop:enable Metrics/MethodLength

  def display_scores
    puts "#{human.name}'s score: #{human.score}  |  #{computer.name}'s score: #{computer.score}"
  end

  def clear
    system 'clear'
  end

  def grand_winner?
    human.score == SCORE_TO_WIN || computer.score == SCORE_TO_WIN
  end

  def display_grand_winner
    if human.score > computer.score
      puts "#{human.name} are the grand winner with #{human.score} point(s)!"
    else
      puts "#{computer.name} is the grand winner with #{computer.score} point(s)!"
    end
  end
  # rubocop:enable Layout/LineLength

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be 'y' or 'n'."
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_player = @first_to_move
    clear
  end
end

game = TTTGame.new
game.play
