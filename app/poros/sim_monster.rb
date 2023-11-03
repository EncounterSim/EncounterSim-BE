class SimMonster
  attr_reader :name, :armor_class, :hit_points, :damage_dice,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :attacks, :id, :damage_dealt
  
  def initialize(data)
    @id = nil
    @name = data[:name]    
    @armor_class = data[:armor_class].first[:value] 
    @hit_points = data[:hit_points]    
    @damage_dice = data[:hit_dice]    
    @strength = (data[:strength] - 10) / 2
    @dexterity = (data[:dexterity] - 10) / 2
    @constitution = (data[:constitution] - 10) / 2
    @intelligence = (data[:intelligence] - 10) / 2
    @wisdom = (data[:wisdom] - 10) / 2
    @charisma = (data[:charisma] - 10) / 2

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

  private

  def get_attacks(attacks_array)
    attacks_array.map do |attack|
      Attack.new(attack)
    end
  end
end