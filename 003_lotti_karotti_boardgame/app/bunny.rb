require "securerandom"

class Bunny
  attr_reader :id, :color

  def initialize(color)
    @id = SecureRandom.alphanumeric(3)
    @color = color
  end
end
