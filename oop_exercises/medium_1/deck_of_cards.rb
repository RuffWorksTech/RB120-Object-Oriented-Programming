# Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards.

# The Deck class should provide a #draw method to deal one card. The Deck should be shuffled when it is initialized and, if it runs out of cards, it should reset itself by generating a new set of 52 shuffled cards.



class Deck
  RANKS = (Array(2..10) + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.each_with_object([]) do |rank, deck|
      SUITS.each do |suit|
        deck << Card.new(rank, suit)
      end
    end

    @deck.shuffle!
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  FACE_RANKS = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  SUIT_RANKS = %w(Diamonds Clubs Hearts Spades)

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    if obtain_rank == other_card.obtain_rank
      obtain_suit <=> other_card.obtain_suit
    else
      obtain_rank <=> other_card.obtain_rank
    end
  end

  def obtain_suit
    SUIT_RANKS.index(suit)
  end

  def obtain_rank
    FACE_RANKS.fetch(rank, rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.