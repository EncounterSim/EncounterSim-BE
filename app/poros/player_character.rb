class PlayerCharacter 
  attr_reader :name, :hit_points, :armor_class, :damage_die,
              :strength, :dexterity, :constitution, :intelligence,
              :wisdom, :charisma, :level
              
  def initialize(data)
    @level = data[:level]
    @name = data[:name]
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
end