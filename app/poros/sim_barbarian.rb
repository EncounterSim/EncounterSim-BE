class SimBarbarian < PlayerCharacter

  def initialize(data)
    super
  end

  def determine_action
    super
  end

  def melee_attack
    super
  end

  def take_damage(amount)
    @hit_points -= (amount / 2).round
  end
end