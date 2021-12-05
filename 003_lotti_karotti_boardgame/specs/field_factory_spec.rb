require "rspec"
require_relative "../app/field_factory"

RSpec.describe FieldFactory do
  let(:factory) { described_class }

  context ".for" do
    context "a regular field" do
      let(:regular_field) { factory.for(:regular) }

      it "returns a new regular field" do
        expect(regular_field).to be_kind_of(RegularField)
        expect(regular_field.trap?).to eq(false)
        expect(regular_field.finish?).to eq(false)
      end
    end

    context "a trap field" do
      let(:trap_field) { factory.for(:trap) }

      it "returns a new trap field" do
        expect(trap_field).to be_kind_of(TrapField)
        expect(trap_field.trap?).to eq(true)
        expect(trap_field.finish?).to eq(false)
      end
    end

    context "a finish field" do
      let(:finish_field) { factory.for(:finish) }

      it "returns a new finish field" do
        expect(finish_field).to be_kind_of(FinishField)
        expect(finish_field.trap?).to eq(false)
        expect(finish_field.finish?).to eq(true)
      end
    end
  end
end
