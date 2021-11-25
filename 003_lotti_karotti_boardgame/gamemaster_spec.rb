require "rspec"
require "ostruct"
require_relative "gamemaster.rb"
require_relative "player.rb"

RSpec.describe Gamemaster do
  subject(:gamemaster) { Gamemaster.new }

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
    let(:player) { Player.new("blue")}

    it "gets the bunny to be moved" do
      expect(gamemaster.send(:move_bunny, player)).to eq("blue-1")
    end
  end
end
