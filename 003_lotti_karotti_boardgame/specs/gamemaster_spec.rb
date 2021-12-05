require "rspec"
require "ostruct"
require_relative "../app/gamemaster"
require_relative "../app/player"
require_relative "../app/bunny"
require_relative "../app/bunny_pool"

RSpec.describe Gamemaster do
  subject(:gamemaster) { Gamemaster.new }

  context "#show_board" do
    it "shows the board" do
      expect { gamemaster.show_board }
        .to output(
          <<~TEXT
            - Lotti Karotti Game Board -

            #-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


        TEXT
        ).to_stdout
    end

    it "shows board with an activated trap" do
      gamemaster.send(:spin_carrot)
      expect { gamemaster.show_board }
        .to output(
          <<~TEXT
            - Lotti Karotti Game Board -

            #-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-🔥-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


        TEXT
        ).to_stdout
    end

    it "shows the right traps" do
      gamemaster.send(:spin_carrot)
      gamemaster.send(:spin_carrot)
      expect { gamemaster.show_board }
        .to output(
          <<~TEXT
            - Lotti Karotti Game Board -

            #-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-🔥-#-🥕


        TEXT
        ).to_stdout
    end

    it "shows bunny on occupied field" do
      gamemaster.send(:board).fields[2].occupied_by = Bunny.new("red")
        expect { gamemaster.show_board }
          .to output(
            <<~TEXT
              - Lotti Karotti Game Board -

              #-#-🐰-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


          TEXT
          ).to_stdout
    end

    it "shows bunny in danger on trap field" do
      gamemaster.send(:board).fields[3].occupied_by = Bunny.new("red")
        expect { gamemaster.show_board }
          .to output(
            <<~TEXT
              - Lotti Karotti Game Board -

              #-#-#-(🐰️)-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


          TEXT
          ).to_stdout
    end

    it "shows hole when bunny swallowed" do
      gamemaster.send(:spin_carrot)
      gamemaster.send(:board).fields[12].occupied_by = Bunny.new("red")
      expect { gamemaster.show_board }
          .to output(
            <<~TEXT
              - Lotti Karotti Game Board -

              #-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-🔥-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


          TEXT
          ).to_stdout
    end
  end

  context "#play" do
    it "returns the game state after a game is finished" do
      pending

      expect(gamemaster.play)
        .to eq(OpenStruct.new(
          winner: kind_of(Player), rounds: be > 0))
    end
  end

  context "#game_state" do
    it "returns the current game state" do
      expect(gamemaster.game_state).to eq(OpenStruct.new(winner: nil, rounds: 0))
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
    let(:fields) { 3 }
    let(:board) { gamemaster.board }

    it "moves the bunny" do
      expect { gamemaster.move_bunny(fields, bunny) }
        .to change { board.fields[2].occupied_by }.from(nil).to(bunny)
    end

    it "ignores occupied field and doesn't count as a jump" do
      blocking_bunny = Bunny.new("red")
      gamemaster.board.fields[0].occupied_by = blocking_bunny

      expect { gamemaster.move_bunny(fields, bunny) }
        .to change { board.fields[3].occupied_by }.from(nil).to(bunny)
    end

    it "ignores multiple occupied fields and doesn't count as a jumps" do
      blocking_bunny1 = Bunny.new("red")
      blocking_bunny2 = Bunny.new("green")
      gamemaster.board.fields[0].occupied_by = blocking_bunny1
      gamemaster.board.fields[1].occupied_by = blocking_bunny2

      expect { gamemaster.move_bunny(fields, bunny) }
        .to change { board.fields[4].occupied_by }.from(nil).to(bunny)
    end

    it "ignores open holes but counts the jump" do

    end

    it "falls down if the last jump is a hole" do

    end

    it "switches game state if field is carrot" do

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
