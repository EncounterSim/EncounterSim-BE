class SimMonster
  attr_reader :id, :name, :armor_class, :hit_points, :strength, 
              :dexterity, :constitution, :intelligence, :wisdom,
              :charisma, :proficiencies, :prof_bonus, :special_abilities, 
              :attacks, :image, :damage_dealt, :attacks_attempted,
              :attacks_successful, :attacks_against_me, :attacks_hit_me

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
    @attacks_attempted = 0
    @attacks_successful = 0
    @attacks_against_me = 0
    @attacks_hit_me = 0
    @image = data[:image]
  end

  def determine_action
    multiattack = @attacks.select {|attack| attack.name == "Multiattack"}
    if multiattack == []
      return [{ attack: @attacks.max_by {|attack| attack.max_damage}, count: 1 }]
    else
      attacks = multiattack[0].action.select { |action| action[:type] != "ability" }
      attacks.map {|each| {attack: @attacks.select {|a| a.name == each[:action_name]}[0], count: each[:count]}}
    end
  end

  def damage_output(num)
    @attacks_successful += 1
    @damage_dealt += num
  end
  
  def reset_damage_dealt
    @damage_dealt = 0
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