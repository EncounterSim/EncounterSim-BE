class SimMonster
  attr_reader :name, :armor_class, :hit_points, :damage_dice,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :attacks
  
  def initialize(data)
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
  end

  private

  def get_attacks(attacks_array)
    attacks_array.map do |attack|
      Attack.new(attack)
    end
  end
end