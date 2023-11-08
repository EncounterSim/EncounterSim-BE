class SimRogue < PlayerCharacter

  def initialize(data)
    super
    @resources = 0
  end

  def melee_attack
    attack_mod = @strength > @dexterity ? @strength : @dexterity
    if (1..2).to_a.sample == 2
      attack_info = { name: "Melee Attack",
                      attack_bonus: attack_mod + @prof_bonus,
                      damage: [
                                {damage_dice: @damage_die + "+#{attack_mod}"},
                                {damage_dice: "#{@class_specific[:sneak_attack][:dice_count]}d#{@class_specific[:sneak_attack][:dice_value]}"}
                              ]
                    }
    else
      attack_info = { name: "Melee Attack", attack_bonus: attack_mod + @prof_bonus, damage: [{damage_dice: @damage_die + "+#{attack_mod}"}]}
    end
    [{ attack: Attack.new(attack_info), count: 1 }]
  end

end