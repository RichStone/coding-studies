require_relative "board"
require_relative "deck"
require_relative "bunny_pool"
require_relative "player"
require "ostruct"

class Gamemaster
  def initialize(colors = %w[red green])
    @board = Board.new
    @pools = []
    @players = []
    colors.each { |color| @pools << BunnyPool.new(5, color); @players << Player.new(color)}
    @deck = Deck.new
    @game_state = OpenStruct.new(winner: nil, rounds: 0, status: "ongoing")
  end

  attr_reader :board, :pools, :game_state, :players, :pools, :deck

  def spin_carrot
    new_hole = board.spin
    if (bunny = new_hole&.occupied_by)
      new_hole.occupied_by = nil
      remove_bunny(bunny)
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
      break if board.fields[next_position].finish?

      board.fields[next_position].occupied_by.nil? ? potatoes_available -= 1 : redo
    end

    if board.fields[next_position].hole?
      remove_bunny(bunny)
    elsif board.fields[next_position].finish?
      board.fields[next_position].occupied_by = bunny
      game_state.winner = bunny.color
      game_state.status = "finished"
    else
      board.fields[next_position].occupied_by = bunny
    end

    # Remove from current position.
    board.fields[current_position].occupied_by = nil if current_position >= 0
  end

  def remove_bunny(bunny)
    pool = bunny_pool(bunny)
    pool.remove(bunny.id)
    if pool.bunnies.empty?
      pools.delete(pool)
      if pools.count < 2
        game_state.winner = pools.first.color
        game_state.status = "finished"
      end
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

  # Get pool by color.
  def get_pool(color)
    pools.select { |pool| pool.color == color }.first
  end

  # Push the button 🕹.
  def play(delay = 0)
    start_time = Time.now

    puts "Starting the game"
    puts "Board now:"
    show_board
    sleep delay

    while game_state.status != "finished"
      game_state.rounds += 1

      players.each do |player|
        show_board
        puts "🥊 #{player.color[0].capitalize}'s turn in round #{game_state.rounds} 🥊"
        sleep delay

        card = deck.cards.sample
        puts card.visual
        sleep delay

        if card.type == "carrot"
          puts "We gonna spin that thing!🥕"
          spin_carrot
          sleep delay
        else
          chosen_bunny = player.choose_bunny(card.potato_count, get_pool(player.color) ,board)
          puts "Player #{player} chooses to move #{chosen_bunny}"
          move_bunny(card.potato_count, chosen_bunny)
          sleep delay
        end

        puts "Board after move:"
        show_board
        sleep delay
        system "clear"
      end
    end

    show_board
    puts "Game #{game_state.status}! 🏁 🎉"
    puts "And the winner is #{game_state.winner} 🐰 after #{game_state.rounds} rounds and #{(Time.now - start_time).round(2)} seconds"
  end

  def show_board
    board.fields.each do |field|
      case field
      when RegularField
        if field.occupied_by
          print "#{field.occupied_by.color[0].capitalize}🐰#{field.occupied_by.id} - "
        else
          print "# - "
        end
      when TrapField
        if field.hole?
          print "🔥 - "
        else
          if field.occupied_by
            print "❗#{field.occupied_by.color[0].capitalize}🐰#{field.occupied_by.id}❗ - "
          else
            print "🪤 - "
          end
        end
      when FinishField
        if field.occupied_by
          print "#{field.occupied_by.color[0].capitalize} 🐰 🥕 #{field.occupied_by.id}\n\n\n"
        else
          print "🥕\n\n\n"
        end
      end
    end; nil
  end
end
