require "rspec"
require_relative "game_client"

RSpec.describe GameClient do
  let(:game_client) { GameClient.new }

  it "returns a summary after a game is finished" do
    expect(game_client.play).to eq({winner: "1", rounds: 34, duration: "12m"})
  end
end
