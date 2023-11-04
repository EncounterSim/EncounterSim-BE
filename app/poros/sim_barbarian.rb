class SimBarbarian < PlayerCharacter

  def initialize(data)
    super
  end

  def reset_damage_dealt
    super
  end

  def damage_output(num)
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
    (amount / 2).round
  end
end