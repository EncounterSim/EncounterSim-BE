class SimBarbarian < PlayerCharacter

  def initialize(data)
    super
    @resources = 0
  end

  def take_damage(amount)
    @attacks_against_me += 1
    @attacks_hit_me += 1
    @hit_points -= (amount / 2).round
    (amount / 2).round
  end
end