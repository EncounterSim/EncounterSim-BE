class SimMonster
  attr_reader :name, :armor_class, :hit_points, :damage_dice,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :attacks, :id, :image
  
  def initialize(data)
    @id = nil
    @name = data[:name]    
    @armor_class = data[:armor_class].first[:value] 
    @hit_points = data[:hit_points]    
    @damage_dice = data[:hit_dice]    
    @strength = data[:strength]    
    @dexterity = data[:dexterity]    
    @constitution = data[:constitution]    
    @intelligence = data[:intelligence]    
    @wisdom = data[:wisdom]    
    @charisma = data[:charisma]

    @attacks = get_attacks(data[:actions])

    @image = data[:image]
  end

  def determine_action
    multiattack = @attacks.select {|attack| attack.name == "Multiattack"}
    if multiattack == []
      return [{ attack: @attacks.max_by {|attack| attack.max_damage}, count: 1 }]
    else
      multiattack.action.map do |action|
        {
          attack: @attacks.select {|attack| attack.name == action[:action_name]},
          count: action[:count]
        }
      end
    end
  end

  def take_damage(amount)
    @hit_points -= amount
  end

  private

  def get_attacks(attacks_array)
    attacks_array.map do |attack|
      Attack.new(attack)
    end
  end
end