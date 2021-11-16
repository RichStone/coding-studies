require "rspec"
require_relative "field"
require_relative "field_factory"

RSpec.describe Field do
  let(:field) { Field.new }

  context "#finish?" do
    it "returns false per default" do
      expect(field.finish?).to eq(false)
    end

    context "when it's a finish field" do
      let(:field) { FieldFactory.for(:finish) }

      it "returns true" do
        expect(field.finish?).to eq(true)
      end
    end
  end

  context "#trap?" do
    it "returns false per default" do
      expect(field.trap?).to eq(false)
    end

    context "when it's a trap field" do
      let(:field) { FieldFactory.for(:trap) }

      it "returns true" do
        expect(field.trap?).to eq(true)
      end
    end
  end

  context "#hole?" do
    it "returns false per default" do
      expect(field.hole?).to eq(false)
    end
  end
  
  context "#switch_hole!" do
    context "with a trap field" do
      let(:field) { FieldFactory.for(:trap) }

      it "turns trap field into a dangerous hole" do
        expect(field.hole?).to eq(false)
        expect(field.switch_hole!.hole?).to eq(true)
      end

      it "turns hole back to non-hole" do
        expect(field.switch_hole!.hole?).to eq(true)
        expect(field.switch_hole!.hole?).to eq(false)
      end
    end

    it "does not switch non-trap fields" do
      expect(field.hole?).to eq(false)
      expect(field.switch_hole!.hole?).to eq(false)
    end
  end
end
