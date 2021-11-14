require "rspec"
require_relative "board"

RSpec.describe Board do
  let(:board) { Board.new }

  it "initializes a board with 27 fields" do
    expect(board.fields.count).to eq(27)
  end

  it "has 'finish' field as the last field" do
    expect(board.fields.first.finish?).to eq(false)
    expect(board.fields[5].finish?).to eq(false)
    expect(board.fields.last.finish?).to eq(true)
  end
end
