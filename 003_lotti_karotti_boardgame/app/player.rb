require "ostruct"

class Player
  private

  def initialize(color)
    @color = color
  end

  public

  attr_reader :color

  def choose_bunny(move_fields, bunny_pool, board)
    # Random choice mode, later also modes based on board position.
    bunny_pool.bunnies.sample
  end

  def to_s
    "🤽 #{color} Player"
  end
end
