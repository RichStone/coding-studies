require_relative "bunny"

class BunnyPool

  private

  def initialize(amount, color)
    @bunnies = []
    amount.times do
      @bunnies << Bunny.new(color)
    end
    @color = color
  end

  public

  attr_reader :bunnies, :color

  def get(id)
    bunnies.select { |bunny| bunny.id == id }.first
  end

  def remove(id)
    bunnies.delete_if { |bunny| bunny.id == id }.first
  end
end
