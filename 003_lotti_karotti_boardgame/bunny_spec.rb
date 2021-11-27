require "rspec"
require_relative "bunny"

RSpec.describe Bunny do
  let(:bunny) { Bunny.new("red") }

  it "is a figure with color and ID" do
    expect(bunny).to be_a(Bunny)
    expect(bunny.color).to eq("red")
    expect(bunny.id).to be_a(String)
  end
end
