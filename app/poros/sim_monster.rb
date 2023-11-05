class SimMonster
  attr_reader :id, :name, :armor_class, :hit_points, :strength, 
              :dexterity, :constitution, :intelligence, :wisdom,
              :charisma, :proficiencies, :prof_bonus, :special_abilities, 
              :attacks, :attacks, :damage_dealt
  
  def initialize(data)
    @id = nil
    @name = data[:name]
    @armor_class = data[:armor_class].first[:value]
    @hit_points = data[:hit_points]
    @strength = (data[:strength] - 10) / 2
    @dexterity = (data[:dexterity] - 10) / 2
    @constitution = (data[:constitution] - 10) / 2
    @intelligence = (data[:intelligence] - 10) / 2
    @wisdom = (data[:wisdom] - 10) / 2
    @charisma = (data[:charisma] - 10) / 2
    @proficiencies = data[:proficiencies]
    @prof_bonus = data[:proficiency_bonus]
    @special_abilities = data[:special_abilities]
    @attacks = get_attacks(data[:actions])
    @damage_dealt = 0
  end

  def determine_action
    multiattack = @attacks.select {|attack| attack.name == "Multiattack"}
    if multiattack == []
      return [{ attack: @attacks.max_by {|attack| attack.max_damage}, count: 1 }]
    else
      attacks = multiattack[0].action.select { |action| action[:type] != "ability" }
      this = attacks.map {|each| {attack: @attacks.select {|a| a.name == each[:action_name]}[0], count: each[:count]}}
    end
  end

  def reset_damage_dealt
    @damage_dealt = 0
  end

  def damage_output(num)
    @damage_dealt += num
  end

  def take_damage(amount)
    @hit_points -= amount
    amount
  end

  def saving_throw(save_mod)
    prof = @proficiencies.select {|each| each[:proficiency][:index][-3..-1] == save_mod}
    if prof == []
      mods = {"str": @strength, "dex": @dexterity, "con": @constitution, "wis": @wisdom, "cha": @charisma, "int": @intelligence}
      mods[save_mod]
    else
      prof[0][:value]
    end
  end

  private

  def get_attacks(attacks_array)
    attacks_array.map do |attack|
      Attack.new(attack)
    end
  end
end