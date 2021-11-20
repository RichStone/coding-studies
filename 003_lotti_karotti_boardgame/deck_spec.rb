require "rspec"
require_relative "deck"

RSpec.describe Deck do
  subject(:deck) { Deck.new }

  it "has 48 cards" do
    expect(deck.cards.count).to eq(48)
  end

  it "has exactly 12 carrot cards" do
    expect(deck.cards.filter { |card| card.type == "carrot" }.count)
  end
end
