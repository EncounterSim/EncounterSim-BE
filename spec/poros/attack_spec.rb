require 'rails_helper'

RSpec.describe Attack do
  before :each do
    attack_info = {name: "Melee Attack",
                   attack_bonus: 8,
                   damage: [{damage_dice: "2d6+5"}, {damage_dice: "1d8"}]}
    @attack = Attack.new(attack_info)
    paladin_data = { 
      :class=>"Paladin",
      :level=>"5",
      :strength=>"5",
      :dexterity=>"2",
      :constitution=>"3",
      :wisdom=>"1",
      :charisma=>"4",
      :intelligence=>"0",
      :spell1=>"branding-smite",
      :spell2=>"branding-smite",
      :spell3=>"branding-smite",
      :spellcasting=>{
        "spell_slots_level_1": 4,
        "spell_slots_level_2": 2,
        "spell_slots_level_3": 0,
        "spell_slots_level_4": 0,
        "spell_slots_level_5": 0
        },
      :hit_points=>"65",
      :armor_class=>"20",
      :damage_die=>"1d8"
    }
    monster_data = {
      name: "Monster",
      armor_class: [{value: 17}],
      hit_points: 130,
      strength: 20,
      dexterity: 18,
      constitution: 23,
      intelligence: 13,
      wisdom: 10,
      charisma: 15,
      proficiencies: "data[:proficiencies]",
      proficiency_bonus: 8,
      special_abilities: "data[:special_abilities]",
      actions: [{
        "name": "Tentacle",
        "attack_bonus": 9,
        "dc": {"dc_type": {"index": "con"}, "dc_value": 14, "success_type": "none"},
        "damage": [{"damage_dice": "2d6+5"},{"damage_dice": "1d12"}]
        }],
      damage_dealt: 0,
      attacks_attempted: 0,
      attacks_successful: 0,
      attacks_against_me: 0,
      attacks_hit_me: 0,
      image: "data[:image]"
    }
    @paladin = SimPaladin.new(paladin_data)
    @monster = SimMonster.new(monster_data)
  end

  it "has readable attributes" do
    expect(@attack).to be_an Attack
    expect(@attack.name).to be_a String
    expect(@attack.hit_bonus).to be_a Integer
    expect(@attack.damage_dice).to be_an Array
  end

  it "#max_damage" do
    expect(@attack.max_damage).to eq(25)
  end

  it "#attack with saving throw" do
    attack_info1 = {name: "Save dc",
                    dc: {dc_type: {index: "dex"}, dc_value: 15, success_type: "half"},
                    damage: [{damage_dice: "8d6"}]}
    save = Attack.new(attack_info1)
    expect(save.attack(@paladin, @monster)).to be_an Integer
  end
  
  it "#aoe" do
    attack_info1 = {name: "AOE",
                    dc: {dc_type: {index: "dex"}, dc_value: 15, success_type: "half"},
                    damage: [{damage_dice: "8d6"}]}
    save = Attack.new(attack_info1)
    expect(save.aoe([@paladin], @monster)).to be_an Array
  end
  
end