require "rspec"
require_relative "field"

RSpec.describe Field do
  let(:field) { Field.new }

  context "#finish?" do
    it "returns false per default" do
      expect(field.finish?).to eq(false)
    end

    context "when it's a finish field" do
      let(:field) { Field.new(finish: true) }

      it "returns true" do
        expect(field.finish?).to eq(true)
      end
    end
  end
end
