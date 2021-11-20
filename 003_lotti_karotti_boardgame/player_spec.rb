require "rspec"
require_relative "player"

RSpec.describe Player do
  let(:player) { Player.new(color) }

  context "#bunnies" do
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

  # TODO: MAKES DECISION WHICH BUNNY TO PLAY
end
