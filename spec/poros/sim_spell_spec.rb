require 'rails_helper'

RSpec.describe Attack do
  before :each do
    spell_info = {name: "Spell Attack",
                  duration: "instant",
                  casting_time: "1 action",
                  level: 1,
                  damage: {"damage_at_slot_level": {"1": "8d6", "2": "8d6"}},
                  dc: {"dc_type": {"index": "dex"}, "dc_success": "half"},
                  area_of_effect: {"type": "sphere", "size": 20}}
    @spell = SimSpell.new(spell_info)
    paladin_data = { 
      :class=>"Paladin",
      :prof_bonus=>3,
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
      :features=>["this"],
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
      proficiencies: [{proficiency: {index: "con"}, value: 6}],
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

  it "#attack with saving throw" do
    expect(@spell.attack(@monster, @paladin)).to be_an Integer
  end

  it "#attack with roll to hit" do
    spell_info = {name: "Spell Attack",
    duration: "instant",
    casting_time: "1 action",
    level: 1,
    damage: {"damage_at_slot_level": {"1": "8d6", "2": "8d6"}}}

    spell = SimSpell.new(spell_info)

    expect(spell.attack(@monster, @paladin)).to be_an Integer
  end
end