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
      expect(dice.roll).to be_kind_of(Integer)
    end

    it "rolls every side at least once" do
      is_present = false

      dice.sides.each do |side|
        # puts "SIDE: #{side}"

        100.times do |i|
          # puts i
          if dice.roll == side
            is_present = true
            break
          end
        end

        expect(is_present).to eq(true)
      end
    end

    it "does not roll non-existent sides" do
      is_present = false

      [0, 7].each do |side|
        # puts "SIDE: #{side}"

        100.times do |i|
          # puts i
          if dice.roll == side
            is_present = true
            break
          end
        end

        expect(is_present).to eq(false)
      end
    end
  end
end
