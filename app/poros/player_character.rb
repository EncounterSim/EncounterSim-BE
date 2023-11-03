class PlayerCharacter 
  attr_reader :name, :hit_points, :armor_class, :damage_die,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :level, :prof_bonus, :damage_dealt
              
  def initialize(data)
    @level = data[:level].to_i
    @name = data[:name]
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
    @damage_dealt = 0
  end

  def damage_output(num)
    @damage_dealt += num
  end

  def reset_damage_dealt
    @damage_dealt = 0
  end

  def determine_action
    return [{ attack: Attack.new(melee_attack), count: 1 }]
  end

  def melee_attack
    attack_mod = @strength > @dexterity ? @strength : @dexterity
    {
      name: "Melee Attack",
      attack_bonus: attack_mod + @prof_bonus,
      damage: @damage_die
    }
  end

  def take_damage(amount)
    @hit_points -= amount
    amount
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
      SimMonk.new(data)
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