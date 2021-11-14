require_relative "field"

class Board
  attr_reader :fields

  private

  def initialize
    traps = [3, 6, 9, 12, 15, 18, 20, 22, 24]
    @fields = 26.times.map do |i|
      traps.include?(i) ? FieldFactory.for(:trap) : FieldFactory.for(:regular)
    end
    # The last field is the end of game condition field.
    @fields << FieldFactory.for(:finish)
  end
end
