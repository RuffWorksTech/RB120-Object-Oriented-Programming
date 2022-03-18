require 'pry'

PTS_GOAL = 21

class Card
  FACES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  SUITS = %w(Hearts Diamonds Spades Clubs)

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def ace?
    face == 'Ace'
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    cards.shuffle!
  end

  def deal_a_card
    cards.pop
  end
end

module Hand
  def draw_card(new_card)
    hand << new_card
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def display_dealer_cards(card)
    puts "    ___________     ___________ "
    puts "   |           |   |           |"
    puts "   |           |   |           |"
    puts "   |           |   |           |"
    puts "   |#{card.face.center(11)}|   |           |"
    puts "   |           |   |    ???    |"
    puts "   |#{card.suit.center(11)}|   |           |"
    puts "   |           |   |           |"
    puts "   |           |   |           |"
    puts "   |___________|   |___________|"
    puts ""
  end

  def display_cards(hand)
    printed_cards = []
    printed_cards << "    ___________ " * hand.size
    printed_cards << "   |           |" * hand.size
    printed_cards << "   |           |" * hand.size
    printed_cards << "   |           |" * hand.size
    faces = ''
    0.upto(hand.size - 1) do |n|
      faces << "   |#{hand[n].face.center(11)}|"
    end
    printed_cards << faces
    printed_cards << "   |           |" * hand.size
    suits = ''
    0.upto(hand.size - 1) do |n|
      suits << "   |#{hand[n].suit.center(11)}|"
    end
    printed_cards << suits
    printed_cards << "   |           |" * hand.size
    printed_cards << "   |           |" * hand.size
    printed_cards << "   |___________|" * hand.size
    printed_cards << ""
    puts printed_cards
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def display_hand
    puts "#{name}'s cards:"
    display_cards(hand)
    puts "------------------------------------------------------------"
    puts ""
  end

  def display_dealer_initial_card
    puts "#{name}'s cards:"
    display_dealer_cards(hand.first)
    puts "------------------------------------------------------------"
    puts ""
  end

  def total
    total = 0
    hand.each do |card|
      total += 11 if card.ace?
      total += 10 if card.face =~ /(King|Queen|Jack)/
      total += card.face.to_i if !card.ace? && !(card.face =~ /(King|Queen|Jack)/)
    end
    total = handle_aces(total)
  end

  def handle_aces(total)
    hand.select(&:ace?).count.times do
      break if total <= PTS_GOAL
      total -= 10
    end
    total
  end

  def busted?
    total > PTS_GOAL
  end
end

class Participant
  include Hand

  attr_accessor :name, :hand

  def initialize
    @hand = []
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "Enter your name:"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, you must enter something..."
    end
    self.name = name
  end
end

class Dealer < Participant
  BOTS = %w(R2D2 C-3PO Data Goddard WALL-E Optimus)

  def set_name
    self.name = BOTS.sample
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    display_welcome_message
    set_participant_names
    clear
    welcome_player
    main_game
    display_goodbye_message
  end

  def main_game
    loop do
      clear
      deal_cards
      clear
      show_initial_cards

      player_turn
      if player.busted?
        show_all_cards
        show_busted

        if play_again?
          reset
          next
        else
          break
        end
      end

      dealer_turn
      if dealer.busted?
        show_all_cards
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end
      show_all_cards
      show_result
      play_again? ? reset : break
    end
  end

  def display_welcome_message
    puts "Welcome to Twenty One!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty One! Goodbye."
  end

  def set_participant_names
    player.set_name
    dealer.set_name
  end

  def welcome_player
    puts "Welcome, #{player.name}!"
    sleep(3)
  end

  def deal_cards
    puts "The dealer (#{dealer.name}) is dealing the cards..."
    sleep(4)
    2.times do
      player.draw_card(deck.deal_a_card)
      dealer.draw_card(deck.deal_a_card)
    end
  end

  def show_initial_cards
    player.display_hand
    dealer.display_dealer_initial_card
  end

  def clear_and_show_initial_cards
    clear
    show_initial_cards
  end

  def show_all_cards
    clear
    player.display_hand
    dealer.display_hand
  end

  def player_turn
    first_loop = true
    hit_stack = []
    loop do
      break if player.busted?
      if first_loop
        puts "#{player.name}'s turn..."
        sleep(3)
      end

      puts "Will you (h)it or (s)tay?"
      move = nil
      loop do
        move = gets.chomp.downcase
        break if %w(h s).include?(move)
        puts "Sorry, you must enter 'h' for hit or 's' for stay."
      end

      if move == 's'
        clear_and_show_initial_cards
        print_turn_and_hits(hit_stack)
        puts "#{player.name} has chosen to stay with #{player.total} points."
        sleep(3)
        break
      else
        player.draw_card(deck.deal_a_card)
        clear_and_show_initial_cards
        hit_stack << "#{player.name} hits."
        print_turn_and_hits(hit_stack)
        sleep(3)
      end
      first_loop = false
    end
  end

  def print_turn_and_hits(hit_stack)
    puts "#{player.name}'s turn..."
    puts hit_stack
  end

  def dealer_turn
    clear_and_show_initial_cards
    puts "#{dealer.name}'s turn..."
    sleep(2)
    show_all_cards
    puts "#{dealer.name}'s turn..."
    sleep(2)

    hit_stack = []
    loop do
      if dealer.total >= (PTS_GOAL - 4) && !dealer.busted?
        puts "#{dealer.name} stays with #{dealer.total} points."
        sleep(3)
        break
      elsif dealer.busted?
        break
      else
        dealer.draw_card(deck.deal_a_card)
        show_all_cards
        puts "#{dealer.name}'s turn..."
        hit_stack << "#{dealer.name} hits..."
        puts hit_stack
        sleep(3)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_result
    if player.total > dealer.total
      puts "#{player.name} wins with #{player.total} points"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins with #{dealer.total} points!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, you must enter 'y' or 'n'."
    end

    answer == 'y'
  end

  def reset
    player.hand = []
    dealer.hand = []
    self.deck = Deck.new
  end

  def clear
    system 'clear'
  end
end

game = TwentyOne.new
game.start
