require_relative "board"
require "ostruct"

class Gamemaster

  private

  def initialize
    @board = Board.new
    @game_state = OpenStruct.new(winner: nil, rounds: 0)
  end

  attr_reader :board

  def spin_carrot
    board.spin
  end

  public

  attr_reader :game_state

  def play
    # TODO: Initialize and store all the core objects.
    # TODO: Run game.
    # TODO: Return the game state after a winner has been determined.
    nil
  end

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
