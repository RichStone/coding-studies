require_relative "board"

class Gamemaster

  private

  def initialize
    @board = Board.new
  end

  attr_reader :board

  def spin_carrot
    board.spin
  end

  public

  def show_board
    puts "- Lotti Karotti Game Board -\n\n"
    board.fields.each do |field|
      case field
      when RegularField
        print "#-"
      when TrapField
        if field.hole?
          print "🔥-"
        else
          print "⚪️-"
        end
      when FinishField
        print "🥕\n\n\n"
      end
    end
  end
end
