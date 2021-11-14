require_relative "field"

class Board
  attr_reader :fields

  private

  def initialize
    traps = [3, 6, 9, 12, 15, 18, 20, 22, 24]
    @fields = 26.times.map do |i|
      traps.include?(i) ? Field.new(trap: true) : Field.new
    end
    # The last field is the end of game condition field.
    @fields << Field.new(finish: true)
  end
end
