class SimMonk < PlayerCharacter

  def initialize(data)
    super
    @resources = data[:class_specific][:ki_points]
  end

  def count_resources
    @class_specific[:ki_points]
  end

  def determine_action
    attack = best_attack
    if attack.any? {|a| a[:attack].name == "Flurry of Blows"}
      @class_specific[:ki_points] -= 1
    end
    attack
  end

  def melee_attack
    attack_mod = @strength > @dexterity ? @strength : @dexterity
    attack_info = { name: "Melee Attacks", attack_bonus: attack_mod + @prof_bonus, damage: [{damage_dice: @damage_die + "+#{attack_mod}"}]}
    if @features.any?("Extra Attack")
      attack_array = [{ attack: Attack.new(attack_info), count: 2 }]
    else
      attack_array = [{ attack: Attack.new(attack_info), count: 1 }]
    end
    if @features.any?("Flurry of Blows")
      if count_resources > 0
        attack_info = { name: "Flurry of Blows", attack_bonus: attack_mod + @prof_bonus, damage: [{damage_dice: "#{@class_specific[:martial_arts][:dice_count]}d#{@class_specific[:martial_arts][:dice_value]}+#{attack_mod}"}]}
        attack_array << { attack: Attack.new(attack_info), count: 2 }
      end
    end
    attack_array
  end

end