require 'ostruct'

class Deck
  attr_reader :cards

  private

  def initialize
    @cards = []
    @cards << (1..12).map { |_| OpenStruct.new(type: "potato", potato_count: 1, visual: "🥔") }
    @cards << (1..12).map { |_| OpenStruct.new(type: "potato", potato_count: 2, visual: "🥔🥔") }
    @cards << (1..12).map { |_| OpenStruct.new(type: "potato", potato_count: 3, visual: "🥔🥔🥔") }
    @cards << (1..12).map { |_| OpenStruct.new(type: "carrot", potato_count: 0, visual: "🥕") }
    @cards.flatten!
  end
end

