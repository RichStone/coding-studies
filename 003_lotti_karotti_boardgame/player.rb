require "ostruct"

class Player
  attr_reader :bunnies

  # TODO: Pass a Board and a Bunny instance.
  def choose_bunny(board)
    # TODO: This will actually return a Bunny instance.
    "blue-1"
  end

  private

  # TODO: Player should not create bunnies: New design.
  # TODO: Make bunnies their own class.
  # TODO: For every player color create a bunny pool.
  # TODO: Remove initialization from Player.
  def initialize(color)
    @bunnies = (1..4).map do |number|
      OpenStruct.new(id: number, color: color)
    end
  end
end
