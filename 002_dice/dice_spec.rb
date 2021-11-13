require "rspec"
require_relative "dice"

describe Dice do
  subject(:dice) { Dice.new }

  context "#sides" do
    context "for a standard dice" do
      it "has 6 sides" do
        expect(dice.sides.count).to eq(6)
      end
    end
  end

  context "#roll" do
    it "returns an Integer" do
      expect(dice.roll).to be_a_kind_of(Integer)
    end

    # TODO: do this for every dice side
    it "1 appears on the dice" do
      is_present = false
      1000.times do
        is_present = true if dice.roll == 1
      end
      expect(is_present).to eq(true)
    end

    it "7 does not appear on the dice" do
      is_present = false
      1000.times do
        is_present = true if dice.roll == 7
      end
      expect(is_present).to eq(false)
    end
  end
end
