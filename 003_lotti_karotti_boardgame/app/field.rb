class Field

  private

  attr_reader :finish, :trap
  attr_accessor :hole

  def initialize(trap: false, finish: false, hole: false)
    @finish = finish
    @trap = trap
    @hole = hole
    @occupied_by = nil
  end

  public

  attr_accessor :occupied_by

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
    return self unless trap?

    self.hole = !hole
    self
  end
end
