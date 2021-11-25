require "rspec"
require_relative "player"
require_relative "board"

RSpec.describe Player do
  context "#bunnies" do
    let(:player) { Player.new(color) }
    let(:color) { "green" }

    context "with a green color" do
      it "returns 4 green bunnies" do
        expect(player.bunnies.count).to eq(4)
        player.bunnies.each do |bunny|
          expect(bunny.color).to eq("green")
        end
      end
    end

    context "with a red color" do
      let(:color) { "red" }

      it "has bunnies with red colors" do
        expect(player.bunnies.count).to eq(4)
        player.bunnies.each do |bunny|
          expect(bunny.color).to eq("red")
        end
      end
    end
  end

  context "#choose_bunny" do
    let(:player) { Player.new("blue") }
    let(:board) { Board.new }

    it "returns the bunny to be moved" do
      expect(player.choose_bunny(board)).to eq("blue-1")
    end
  end
end
