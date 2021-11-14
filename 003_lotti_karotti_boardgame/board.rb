require_relative "field"

class Board
  attr_reader :fields

  private

  def initialize
    @fields = 26.times.map { |_| Field.new }
    @fields << Field.new(finish: true)
  end
end
