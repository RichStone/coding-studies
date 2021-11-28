require "rspec"
require "ostruct"
require_relative "gamemaster"
require_relative "player"
require_relative "bunny"
require_relative "bunny_pool"

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
    let(:bunny) { Bunny.new("red") }
    let(:fields) { 3 }
    let(:board) { gamemaster.send(:board) }

    it "gets the bunny to be moved" do
      expect { gamemaster.send(:move_bunny, fields, bunny) }
        .to change { board.fields[2].occupied_by }.from(nil).to(be_a(Bunny))
    end

    context "when the player can't move a bunny" do
      # TODO: Player returns nil?
      it "returns early" do
        # TODO: return early.
      end
    end
  end
end
