require "rspec"
require_relative "../app/board"

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

  context "SPIN_ORDER" do
    it "returns the spin order" do
      expect(described_class::SPIN_ORDER)
        .to eq([12, 24, 15, 22, 6, 3, 18, 9, 20])
    end
  end

  context "#spin" do
    it "turns next trap field into a hole and previous back" do
      board.spin
      expect(board.fields[12]).to be_a(TrapField)
      expect(board.fields[12].hole?).to eq(true)
      expect(board.fields[20].hole?).to eq(false)
      board.spin
      expect(board.fields[24].hole?).to eq(true)
      expect(board.fields[12].hole?).to eq(false)
      board.spin
      expect(board.fields[24].hole?).to eq(false)
      expect(board.fields[15].hole?).to eq(true)
    end

    it "turns last trap field into a hole and penultimate back" do
      9.times { board.spin }
      expect(board.fields[20].hole?).to eq(true)
      expect(board.fields[9].hole?).to eq(false)
    end

    it "switches all fields to non-hole on spin cycle end" do
      10.times { board.spin }
      board.fields.each do |field|
        expect(field.hole?).to eq(false)
      end
    end

    it "switches correctly again on cycle renewal" do
      11.times { board.spin }
      expect(board.fields[12].hole?).to eq(true)
      expect(board.fields[20].hole?).to eq(false)
      board.spin
      expect(board.fields[24].hole?).to eq(true)
      expect(board.fields[12].hole?).to eq(false)
      board.spin
      expect(board.fields[24].hole?).to eq(false)
      expect(board.fields[15].hole?).to eq(true)
    end
  end

  context "#spin_count" do
    it "equals to amount of traps" do
      expect(described_class::SPIN_CYCLE).to eq(10)
    end
  end
end
