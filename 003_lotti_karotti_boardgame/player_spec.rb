require "rspec"
require_relative "player"
require_relative "board"

RSpec.describe Player do
  context "#choose_bunny" do
    let(:player) { Player.new("blue") }
    let(:board) { Board.new }
    let(:bunny_pool) { BunnyPool.new(5, "yellow") }
    let(:move_fields) { 2 }

    it "returns the bunny to be moved" do
      expect(player.choose_bunny(move_fields, bunny_pool, board)).to be_a(Bunny)
    end
  end
end
