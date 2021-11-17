require "rspec"
require_relative "gamemaster.rb"

RSpec.describe Gamemaster do
  subject(:gamemaster) { Gamemaster.new }

  it "shows the board" do
    expect { gamemaster.show_board }
      .to output(
        <<~TEXT
          - Lotti Karotti Game Board -

          #-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕


        TEXT
      ).to_stdout
  end
end
