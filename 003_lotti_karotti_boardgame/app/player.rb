require "ostruct"

class Player
  private

  def initialize(color)
    @color = color
  end

  public

  def choose_bunny(move_fields, bunny_pool, board)
    # Random choice mode, later also modes based on board position.
    # TODO: For Random mode, make sure chosen Bunny is movable (i.e. no holes or blocks)
    bunny_pool.bunnies.sample
  end
end
