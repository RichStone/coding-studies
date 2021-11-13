class Dice
  def sides
    (1..6).to_a
  end

  def roll
    sides.sample
  end
end
