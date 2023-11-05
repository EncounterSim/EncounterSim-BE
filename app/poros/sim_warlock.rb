class SimWarlock < PlayerCharacter

  def initialize(data)
    super
    @resources = spell_count
  end

  def damage_output(num)
    super
  end

  def reset_damage_dealt
    super
  end

  def best_attack
    super
  end

  def determine_action
    super
  end

  def melee_attack
    super
  end

  def cantrip
    super
  end

  def spell_to_hit
    super
  end
  
  def cast_level
    super
  end

  def get_spell_slot
    super
  end

  def take_damage(amount)
    super
  end

  def spell_save_dc
    super
  end

  def saving_throw(save_mod)
    super
  end

  def spell_count
    @spellcasting.sum {|k, v| k.to_s[-1].to_i > 0 ? v : 0}
  end
end