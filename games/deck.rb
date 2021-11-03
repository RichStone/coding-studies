require_relative "card"

class PokerDeck
  VALUE_RANGE = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
  SUITS = [:spades, :hearts, :clubs, :diamonds]

  attr_reader :cards

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUE_RANGE.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def pop
    index = rand(cards.count)
    card = cards[index]
    cards.delete_at(index)
    card
  end
end
