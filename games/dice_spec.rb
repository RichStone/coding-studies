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
    it "gives an Integer" do
      expect(dice.roll.class).to eq(Integer)
    end
  end
end
