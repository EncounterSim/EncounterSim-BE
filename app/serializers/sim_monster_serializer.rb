class SimMonsterSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :armor_class, :hit_points, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :attacks, :image
end
