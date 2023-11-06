class PlayerCharacter 
  attr_reader :id, :name, :hit_points, :armor_class, :damage_die,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :level, :prof_bonus, :damage_dealt,
              :features, :class_specific, :spells, :spellcasting, :resources,
              :attacks_attempted, :attacks_successful, :attacks_against_me,
              :attacks_hit_me
              
  def initialize(data)
    @id = data[:id]
    @level = data[:level].to_i
    @name = data[:class]
    @prof_bonus = data[:prof_bonus]
    @hit_points = data[:hit_points].to_i
    @armor_class = data[:armor_class].to_i
    @damage_die = data[:damage_die]
    @strength = data[:strength].to_i
    @dexterity = data[:dexterity].to_i
    @constitution = data[:constitution].to_i
    @intelligence = data[:intelligence].to_i
    @wisdom = data[:wisdom].to_i
    @charisma = data[:charisma].to_i
    @spellcasting = data[:spellcasting] if data[:spellcasting]
    @spells = data[:spells]
    @features = data[:features]
    @class_specific = data[:class_specific]
    @damage_dealt = 0
    @attacks_attempted = 0
    @attacks_successful = 0
    @attacks_against_me = 0
    @attacks_hit_me = 0
  end

  def damage_output(num)
    @attacks_successful += 1
    @damage_dealt += num
  end

  def attempt_hit
    @attacks_attempted += 1
  end

  def missed_me
    @attacks_against_me += 1
  end

  def take_damage(amount)
    @attacks_against_me += 1
    @attacks_hit_me += 1
    @hit_points -= amount
    amount
  end

  def reset_damage_dealt
    @damage_dealt = 0
  end

  def best_attack
    options = []
    if @spellcasting
      spells = @spells.inject([]) { |result,h| result << h unless result.include?(h); result }
      best_spell = spells.max_by {|spell| spell.max_damage(get_spell_slot)}
      options << {attack: [{ attack: best_spell, count: 1}], damage: best_spell.max_damage(get_spell_slot)}
    end
    attack = melee_attack[0]
    melee_damage = 0
    (attack[:count]).times do 
      melee_damage += attack[:attack].max_damage
    end
    options << {attack: melee_attack, damage: melee_damage}

    attack = cantrip[0]
    cantrip_damage = 0
    (attack[:count]).times do 
      cantrip_damage += attack[:attack].max_damage
    end
    options << {attack: cantrip, damage: cantrip_damage}
    options.max_by {|each| each[:damage]}[:attack]
  end

  def determine_action
    best_attack
  end

  def melee_attack
    attack_mod = @strength > @dexterity ? @strength : @dexterity
    attack_info = { name: "Melee Attack", attack_bonus: attack_mod + @prof_bonus, damage: [{damage_dice: @damage_die + "+#{attack_mod}"}]}
    if @features.any?("Extra Attack")
      [{ attack: Attack.new(attack_info), count: 2 }]
    else
      [{ attack: Attack.new(attack_info), count: 1 }]
    end
  end

  def cantrip
    cantrip_info = { name: "Cantrip", attack_bonus: spell_to_hit, damage: [{damage_dice: @damage_die}] }
    [{ attack: Attack.new(cantrip_info), count: 1 }]
  end

  def spell_to_hit
    [@wisdom, @charisma, @intelligence].max
  end

  def cast_level
    slot = get_spell_slot
    @spellcasting[@spellcasting.keys.select {|e| e.to_s[-1] == slot}.first] -= 1
    slot
  end

  def get_spell_slot
    @spellcasting.select {|k, v| v > 0}.keys.last.to_s[-1]
  end

  def spell_count
    require 'pry'; binding.pry
    @spellcasting.sum {|k, v| k.to_s[-1].to_i > 0 ? v : 0}
  end

  def count_resources
    resources = 0
    if @spellcasting
      resources += spell_count
    end
    resources
  end

  def spell_save_dc
    spell_mods = {
      "Bard": @charisma,
      "Cleric": @wisdom,
      "Druid": @wisdom,
      "Fighter": @intelligence,
      "Paladin": @charisma,
      "Ranger": @wisdom,
      "Rogue": @intelligence,
      "Sorcerer": @charisma,
      "Warlock": @charisma,
      "Wizard": @intelligence
    }
    8 + @prof_bonus + spell_mods[:"#{@name}"]
  end

  def saving_throw(save_mod)
    mods = {"str": @strength, "dex": @dexterity, "con": @constitution, "wis": @wisdom, "cha": @charisma, "int": @intelligence}
    mods[:"#{save_mod}"]
  end

  def self.make_character(data)
    case data[:class]
    when "Barbarian"
      SimBarbarian.new(data)
    when "Bard"
      SimBard.new(data)
    when "Cleric"
      SimCleric.new(data)
    when "Druid"
      SimDruid.new(data)
    when "Fighter"
      SimFighter.new(data)
    when "Monk"
      SimMonk.new(data)
    when "Paladin"
      SimPaladin.new(data)
    when "Ranger"
      SimRanger.new(data)
    when "Rogue"
      SimRogue.new(data)
    when "Sorcerer"
      SimSorcerer.new(data)
    when "Warlock"
      SimWarlock.new(data)
    when "Wizard"
      SimWizard.new(data)
    end
  end
end