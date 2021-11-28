require_relative "field"
require_relative "field_factory"

class Board
  SPIN_ORDER = [12, 24, 15, 22, 6, 3, 18, 9, 20].freeze
  SPIN_CYCLE = SPIN_ORDER.count + 1

  private

  attr_accessor :spin_count

  def initialize
    @spin_count = 0
    # Initialize fields.
    traps = [3, 6, 9, 12, 15, 18, 20, 22, 24]
    @fields = 26.times.map do |i|
      traps.include?(i) ? FieldFactory.for(:trap) : FieldFactory.for(:regular)
    end
    # The last field is the end of game condition field.
    @fields << FieldFactory.for(:finish)
  end

  public

  attr_reader :fields

  def spin
    self.spin_count += 1
    next_field = self.spin_count - 1
    previous_field = self.spin_count - 2

    if self.spin_count == SPIN_CYCLE
      fields[SPIN_ORDER[previous_field]].switch_hole!
      self.spin_count = 0
      return
    end

    # -1 handles the first spin where there is no previous_field yet.
    fields[SPIN_ORDER[previous_field]].switch_hole! if previous_field >= 0
    fields[SPIN_ORDER[next_field]].switch_hole!
    # TODO: Return swallowed bunny_id.
  end
end
