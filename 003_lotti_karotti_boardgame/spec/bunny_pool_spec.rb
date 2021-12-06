require "rspec"
require_relative "../app/bunny_pool"

RSpec.describe BunnyPool do
  let(:bunny_pool) { BunnyPool.new(5, "green") }

  it "creates a pool with 5 green bunnies" do
    expect(bunny_pool.bunnies.count).to eq(5)
    expect(bunny_pool.color).to eq("green")
    expect(bunny_pool.bunnies.first).to be_a(Bunny)
    expect(bunny_pool.bunnies.last).to be_a(Bunny)
  end

  context "#get" do
    let(:bunny) { bunny_pool.bunnies.first }

    it "returns an existing bunny" do
      expect(bunny_pool.get(bunny.id)).to eq(bunny)
    end

    it "returns nil when not found" do
      expect(bunny_pool.get("unknown")).to eq(nil)
    end
  end

  context "#remove" do
    let(:bunny) { bunny_pool.bunnies.first }

    it "removes a bunny from the pool" do
      expect(bunny_pool.get(bunny.id)).to be
      expect { bunny_pool.remove(bunny.id) }
        .to change { bunny_pool.bunnies.count }.from(5).to(4)
      expect(bunny_pool.get(bunny.id)).not_to be
    end

    it "keeps the bunnies unchanged with an unknown ID" do
      expect { bunny_pool.remove("unknown") }
        .not_to change { bunny_pool.bunnies.count }.from(5)
    end
  end
end
