require_relative "field"

class RegularField < Field
  def initialize(trap: false, finish: false)
    super
  end
end

class TrapField < Field
  def initialize(trap: true, finish: false)
    super
  end
end

class FinishField < Field
  def initialize(trap: false, finish: true)
    super
  end
end

class FieldFactory
  TYPES = {
    regular: RegularField,
    trap: TrapField,
    finish: FinishField
  }.freeze

  def self.for(type)
    raise ArgumentError unless TYPES[type]

    TYPES[type].new
  end
end
