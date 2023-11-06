def load_test_data
  data = {
    level: 3,
    class: "Gronk",
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

def create_player_data(class_name)
  player = {
      :class=>class_name,
      :level=>"20",
      :strength=>"5",
      :dexterity=>"5",
      :constitution=>"5",
      :wisdom=>"5",
      :charisma=>"5",
      :intelligence=>"5",
      :spell1=>"fireball",
      :spell2=>"cone-of-cold",
      :spell3=>"acid-arrow",
      :hit_points=>"65",
      :armor_class=>"17",
      :damage_die=>"1d8"
    }
  level_info = DndFacade.new.player(player[:class].downcase)
  player[:prof_bonus] = level_info[player[:level].to_i - 1][:prof_bonus]
  player[:spells] = [DndFacade.new.spell(player[:spell1]), DndFacade.new.spell(player[:spell2]), DndFacade.new.spell(player[:spell3])]
  if level_info[0][:spellcasting]
    player[:spellcasting] = level_info[player[:level].to_i - 1][:spellcasting]
  end
  player[:class_specific] = level_info[player[:level].to_i - 1][:class_specific]
  player[:features] = []
  index = 0
  while index <= (player[:level].to_i - 1)
    feat_names = level_info[index][:features].map { |each| each[:name] }
    player[:features].concat(feat_names)
    index += 1
  end
   @player_data = player
end