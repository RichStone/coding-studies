require "rspec"
require_relative "deck"

describe PokerDeck do
  subject(:deck) { PokerDeck.new }

  it "initializes a new poker deck with 52 cards" do
    expect(deck.cards.count).to eq(52)
    expect(deck.cards.first).to eq(Card.new(2, :spades))
    expect(deck.cards.last).to eq(Card.new(:ace, :diamonds))
  end

  it "defines suits" do
    expect(PokerDeck::SUITS).to eq([:spades, :hearts, :clubs, :diamonds])
  end

  it "defines values" do
    expect(PokerDeck::VALUE_RANGE).to eq(
      [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
    )
  end

  context "#pop" do
    it "returns a card" do
      expect(deck.cards.count).to eq(52)
      expect(deck.pop.class).to eq(Card)
      expect(deck.cards.count).to eq(51)
    end

    it "stops without cards in the deck" do
      deck.cards.pop(52)
      expect(deck.pop).to eq(nil)
    end
  end

  context "#shuffle" do
    it "shuffles the cards with few cards in the original position" do
      pending "find a use case for shuffling cards"

      old_deck = deck
      duplicates = []
      deck.shuffle.cards.each_with_index do |card, i|
        duplicates << card if card == old_deck[i]
      end
      expect(duplicates.count).to < 10
    end
  end
end
