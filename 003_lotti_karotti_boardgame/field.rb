class Field
  def finish?
    finish
  end

  def trap?
    trap
  end

  def hole?
    hole
  end

  def switch_hole!
    # Only change trap fields ever.
    return self unless self.trap?

    self.hole = !self.hole
    self
  end

  private

  attr_reader :finish, :trap
  attr_accessor :hole

  def initialize(trap: false, finish: false, hole: false)
    @finish = finish
    @trap = trap
    @hole = hole
  end
end
