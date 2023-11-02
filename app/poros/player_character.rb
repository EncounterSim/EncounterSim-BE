class PlayerCharacter 
  attr_reader :name, :hit_points, :armor_class, :damage_die,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :level, :prof_bonus
              
  def initialize(data)
    @level = data[:level]
    @name = data[:name]
    @prof_bonus = data[:prof_bonus]
    @hit_points = data[:hit_points]
    @armor_class = data[:armor_class]
    @damage_die = data[:damage_die]
    @strength = data[:strength]
    @dexterity = data[:dexterity]
    @constitution = data[:constitution]
    @intelligence = data[:intelligence]
    @wisdom = data[:wisdom]
    @charisma = data[:charisma]
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
  end
end