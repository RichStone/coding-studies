class Field
  def finish?
    finish
  end

  def trap?
    trap
  end

  private

  attr_reader :finish, :trap

  def initialize(trap: false, finish: false)
    @finish = finish
    @trap = trap
  end
end
