require "ostruct"

class Player
  attr_reader :bunnies

  private

  def initialize(color)
    @bunnies = (1..4).map do |number|
      OpenStruct.new(id: number, color: color)
    end
  end
end
