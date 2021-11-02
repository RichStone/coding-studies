require "rspec"
require_relative "card"

RSpec.describe Card do
  let(:card) { Card.new(5, "hearts") }

  it "returns a new card" do
    expect(card.suite).to eq "hearts"
    expect(card.value).to eq 5
  end
end
