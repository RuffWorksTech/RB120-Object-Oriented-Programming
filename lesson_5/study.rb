# Evaluating a poker hand involves a few steps. First, a player is dealt 5 random cards from a deck. Those 5 cards are then evaluated to know good that poker hand is. The best possible card combinations are (from best to worst) royal flush, straight flush, four of a kind, full house, flush, straight, three of a kind, two pair, and pair. If the hand contains none of the above, then the highest card (2 being the lowest and Ace being the highest) determines the quality of the poker hand.

# Classes:
# - Hand
#     - evaluate
# - Player
# - Deck
#     - deal
# - Card

# Spike:

class Hand
  def initialize
    # obtain 5 cards from deck
  end

  def evaluate
    # checks the combinations to see if one is found
  end
end

class Card
  def initialize
    # needs to consider face value and suit
  end
  
  def score
    # obtains the score of the card considering face cards and number cards
  end
end

class Deck
  def initialize
    # deck of all 13 cards for all four suits (52 in total)
  end
end