class Field
  def finish?
    finish
  end

  private

  attr_reader :finish

  def initialize(finish: false)
    @finish = finish
  end
end
