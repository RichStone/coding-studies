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
    new_hole = board.spin
    # TODO: remove bunny from bunnypool & set occupied_by=nil AFTER bunnypool initialized in gamemaster.
  end

  def move_bunny(fields, bunny)
    board.fields[2].occupied_by = bunny
  end

  public

  attr_reader :game_state

  def play
    # TODO: Initialize and store all the core objects -> Run game -> Return the game state after a winner has been determined or all bunnies have been swallowed.
    nil
  end

  def show_board
    puts "- Lotti Karotti Game Board -\n\n"
    board.fields.each do |field|
      case field
      when RegularField
        if field.occupied_by
          print "🐰-"
        else
          print "#-"
        end
      when TrapField
        if field.hole?
          print "🔥-"
        else
          if field.occupied_by
            print "(🐰️)-"
          else
            print "⚪️-"
          end
        end
      when FinishField
        print "🥕\n\n\n"
      end
    end
  end
end
