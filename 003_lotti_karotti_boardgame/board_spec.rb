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

  it "has trap & non-trap fields" do
    traps = [3, 6, 9, 12, 15, 18, 20, 22, 24]
    traps.each do |index|
      expect(board.fields[index].trap?).to equal(true)
    end

    non_traps = (0..26).to_a - traps
    non_traps.each do |index|
      expect(board.fields[index].trap?).to equal(false)
    end
  end
end
