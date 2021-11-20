require 'ostruct'

class Deck
  def cards
    cards = []
    cards << (1..36).map { |_| OpenStruct.new(type: "asdf") }
    cards << (1..12).map { |_| OpenStruct.new(type: "carrot") }
    cards.flatten
  end
end

