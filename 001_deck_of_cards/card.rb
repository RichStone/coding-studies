class Card
  attr_reader :suite, :value

  def initialize(value, suite)
    @value = value
    @suite = suite
  end

  def ==(card)
    suite == card.suite && value == card.value
  end
end
