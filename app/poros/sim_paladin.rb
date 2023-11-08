class SimPaladin < PlayerCharacter

  def initialize(data)
    super
    @resources = spell_count
  end

  def determine_action
    if @features.any?("Divine Smite")
      melee_attack
    else
      best_attack
    end
  end

  def damage_output(num, type)
    @attacks_successful += 1
    if @features.any?("Divine Smite")
      if count_resources > 0
        slot = cast_level
        smite_damage = 0
        (2 + ((slot.to_i < 5 ? slot.to_i : 4) - 1)).times do
          smite_damage += ((1..8).to_a.sample)
        end
        if type == "crit"
          num += (smite_damage * 2)
        else
          num += smite_damage
        end
      end
    end
    @damage_dealt += num
  end
end