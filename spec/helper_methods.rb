def load_test_data
  data = {
    level: 3,
    name: "Gronk",
    hit_points: 12,
    armor_class: 14,
    damage_die: "1d10",
    strength: 16,
    dexterity: 15,
    constitution: 16,
    intelligence: 10,
    wisdom: 8,
    charisma: 8
  }
  @gronk = PlayerCharacter.new(data)
end