require "rspec"
require "ostruct"
require_relative "../app/gamemaster"
require_relative "../app/player"
require_relative "../app/bunny"
require_relative "../app/bunny_pool"

RSpec.describe Gamemaster do
  subject(:gamemaster) { Gamemaster.new }

  context "#play" do
    xit "returns the game state after a game is finished" do
      pending

      expect(gamemaster.play)
        .to eq(OpenStruct.new(
          winner: kind_of(Player), rounds: be > 0))
    end
  end

  context "#game_state" do
    it "returns the current game state" do
      expect(gamemaster.game_state).to eq(OpenStruct.new(winner: nil, rounds: 0, status: "ongoing"))
    end

    it "returns nil winner initially" do
      expect(gamemaster.game_state.winner).to eq(nil)
    end

    it "returns 0 rounds initially" do
      expect(gamemaster.game_state.rounds).to eq(0)
    end
  end

  context "#move_bunny" do
    let(:bunny) { gamemaster.pools.first.bunnies.first }
    let(:board) { gamemaster.board }

    it "moves the bunny" do
      expect { gamemaster.move_bunny(3, bunny) }
        .to change { board.fields[2].occupied_by }.from(nil).to(bunny)
    end

    it "ignores occupied field and doesn't count as a jump" do
      blocking_bunny = Bunny.new("red")
      gamemaster.board.fields[0].occupied_by = blocking_bunny

      expect { gamemaster.move_bunny(3, bunny) }
        .to change { board.fields[3].occupied_by }.from(nil).to(bunny)
    end

    it "ignores multiple occupied fields and doesn't count as a jumps" do
      blocking_bunny1 = Bunny.new("red")
      blocking_bunny2 = Bunny.new("green")
      gamemaster.board.fields[0].occupied_by = blocking_bunny1
      gamemaster.board.fields[1].occupied_by = blocking_bunny2

      expect { gamemaster.move_bunny(3, bunny) }
        .to change { board.fields[4].occupied_by }.from(nil).to(bunny)
    end

    context "with a 🔥 hole 🔥 in front of the bunny" do
      it "ignores open holes but counts the jump" do
        gamemaster.spin_carrot # Hole is now at index 12 🔥
        bunny = gamemaster.pools.first.bunnies.first
        gamemaster.board.fields[10].occupied_by = bunny

        expect { gamemaster.move_bunny(3, bunny) }
          .to change { board.fields[13].occupied_by }.from(nil).to(bunny)
      end

      it "falls down if the last jump is a hole" do
        gamemaster.spin_carrot # Hole is now at index 12 🔥
        bunny = gamemaster.pools.first.bunnies.first
        gamemaster.board.fields[11].occupied_by = bunny

        expect { gamemaster.move_bunny(1, bunny) }
          .not_to change { board.fields[12].occupied_by }.from(nil)
      end

      it "removes Bunny from the pool" do
        gamemaster.spin_carrot # Hole is now at index 12 🔥
        bunny = gamemaster.pools.first.bunnies.first
        gamemaster.board.fields[11].occupied_by = bunny

        expect { gamemaster.move_bunny(1, bunny) }
          .to change { gamemaster.bunny_pool(bunny) }.from(BunnyPool).to(nil)
      end
    end

    it "switches game state if field is carrot 🥕" do
      bunny = gamemaster.pools.first.bunnies.first
      gamemaster.board.fields[25].occupied_by = bunny
      expect { gamemaster.move_bunny(3, bunny) }
        .to change { gamemaster.game_state.winner }.from(nil).to(bunny.color)
        .and change { gamemaster.game_state.status }.from("ongoing").to("finished")
    end
  end

  context "#spin_carrot" do
    it "removes bunny from field" do
      bunny = gamemaster.pools.first.bunnies.first
      first_hole = gamemaster.board.fields[12]
      first_hole.occupied_by = bunny

      expect { gamemaster.spin_carrot }
        .to change { first_hole.occupied_by }.from(bunny).to(nil)
    end

    it "removes bunny from pool" do
      bunny = gamemaster.pools.first.bunnies.first
      first_hole = gamemaster.board.fields[12]
      first_hole.occupied_by = bunny

      expect { gamemaster.spin_carrot }
        .to change { gamemaster.bunny_pool(bunny) }.from(be_a(BunnyPool)).to(nil)
    end
  end

  context "#remove_bunny" do
    it "changes game state with only 1 pool left" do
      # This is probably a super brittle test with a lot of implicit setup!
      4.times { bunny = gamemaster.pools.first.bunnies.first; gamemaster.remove_bunny(bunny) }
      bunny = gamemaster.pools.first.bunnies.first
      expect { gamemaster.remove_bunny(bunny) }
        .to change { gamemaster.game_state.status }.from("ongoing").to("finished")
        .and change { gamemaster.game_state.winner }.from(nil).to("green")
    end
  end

  context "#bunny_position" do
    it "detects a bunny on their position" do
      bunny = Bunny.new("red")
      gamemaster.board.fields[3].occupied_by = bunny

      expect(gamemaster.bunny_position(bunny)).to eq(3)
    end

    it "returns nil when bunny isn't alive anymore" do
      bunny = gamemaster.pools.first.bunnies.first
      gamemaster.pools.first.remove(bunny.id)
      expect(gamemaster.bunny_position(bunny)).to eq(nil)
    end
  end

  context "#bunny_pool" do
    it "returns pool of a bunny" do
      bunny = gamemaster.pools.first.bunnies.first
      expect(gamemaster.bunny_pool(bunny)).to eq(gamemaster.pools.first)
    end

    it "returns nil if a bunny is not in one of the pools" do
      bunny = Bunny.new("red")
      expect(gamemaster.bunny_pool(bunny)).to eq(nil)
    end
  end
end
