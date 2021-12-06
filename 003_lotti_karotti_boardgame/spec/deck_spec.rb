require "rspec"
require_relative "../app/deck"

RSpec.describe Deck do
  subject(:deck) { Deck.new }

  it "has 48 cards" do
    expect(deck.cards.count).to eq(48)
  end

  it "has exactly 12 carrot cards" do
    expect(deck.cards.filter do |card|
      card.type == "carrot" && card.potato_count == 0
    end.count).to eq(12)
  end

  it "has exactly 12 single-potato cards" do
    expect(deck.cards.filter do |card|
      card.type == "potato" && card.potato_count == 1
    end.count).to eq(12)
  end

  it "has exactly 12 double-potato cards" do
    expect(deck.cards.filter do |card|
      card.type == "potato" && card.potato_count == 2
    end.count).to eq(12)
  end

  it "has exactly 12 triple-potato cards" do
    expect(deck.cards.filter do |card|
      card.type == "potato" && card.potato_count == 3
    end.count).to eq(12)
  end

  it "has no 12 quadruple-potato cards" do
    expect(deck.cards.filter do |card|
      card.type == "potato" && card.potato_count == 4
    end.count).to eq(0)
  end
end
