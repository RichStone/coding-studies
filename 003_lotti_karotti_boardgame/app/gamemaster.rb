require_relative "board"
require "ostruct"

class Gamemaster
  def initialize
    @board = Board.new
    @pools = [BunnyPool.new(5, "red"), BunnyPool.new(5, "green")]
    @game_state = OpenStruct.new(winner: nil, rounds: 0, status: "ongoing")
  end

  attr_reader :board, :pools

  def spin_carrot
    new_hole = board.spin
    if (bunny = new_hole.occupied_by)
      new_hole.occupied_by = nil
      bunny_pool(bunny).remove(bunny.id)
    end
  end

  # @param amount_fields [Integer] Amount of fields to move the Bunny for.
  # @param bunny [Bunny] The Bunny to be moved.
  def move_bunny(amount_fields, bunny)
    current_position = bunny_position(bunny)
    raise "move invalid: Bunny not found in pool nor on the board" unless current_position && bunny_pool(bunny)

    next_position = current_position
    potatoes_available = amount_fields
    loop do
      break if potatoes_available == 0

      next_position += 1
      board.fields[next_position].occupied_by.nil? ? potatoes_available -= 1 : redo
    end

    if board.fields[next_position].hole?
      bunny_pool(bunny).remove(bunny.id)
    elsif board.fields[next_position].finish?
      # TODO: Game state changed.
    else
      board.fields[next_position].occupied_by = bunny
    end
  end

  # Bunny's current position on the board.
  # -1 if alive but not on the board, i.e. he's 1 step away from the board's
  # first position which is 0.
  # nil if the bunny is not alive anymore.
  def bunny_position(bunny)
    position = nil
    board.fields.each_with_index do |field, i|
      position = i if field.occupied_by == bunny
    end

    return position if position
    return -1 if bunny_pool(bunny)
    nil
  end

  # The pool that a bunny belongs to.
  def bunny_pool(bunny)
    pools.reject { |pool| pool.get(bunny.id).nil? }.first
  end

  public

  attr_reader :game_state

  # Push the button 🕹.
  def play
    # TODO: Initialize and store all the core objects -> Run game -> Return the game state after a winner has been determined or <= 1 BunnyPool left.
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
    end; nil
  end
end
