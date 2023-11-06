require 'rails_helper'

RSpec.describe Sim do
  it "works", :vcr do
    barbarian = {
      :class=>"Barbarian",
      :level=>"20",
      :strength=>"5",
      :dexterity=>"4",
      :constitution=>"3",
      :wisdom=>"2",
      :charisma=>"1",
      :intelligence=>"0",
      :spell1=>"acid-arrow",
      :spell2=>"acid-arrow",
      :spell3=>"acid-arrow",
      :hit_points=>"75",
      :armor_class=>"17",
      :damage_die=>"2d6"
    }

    rogue = {
      :class=>"Rogue",
      :level=>"20",
      :strength=>"2",
      :dexterity=>"5",
      :constitution=>"3",
      :wisdom=>"2",
      :charisma=>"1",
      :intelligence=>"0",
      :spell1=>"acid-arrow",
      :spell2=>"acid-arrow",
      :spell3=>"acid-arrow",
      :hit_points=>"55",
      :armor_class=>"17",
      :damage_die=>"1d6"
    }

    monk = {
      :class=>"Monk",
      :level=>"20",
      :strength=>"2",
      :dexterity=>"5",
      :constitution=>"3",
      :wisdom=>"4",
      :charisma=>"1",
      :intelligence=>"0",
      :spell1=>"acid-arrow",
      :spell2=>"acid-arrow",
      :spell3=>"acid-arrow",
      :hit_points=>"55",
      :armor_class=>"19",
      :damage_die=>"1d8"
    }

    paladin = { 
      :class=>"Paladin",
      :level=>"20",
      :strength=>"5",
      :dexterity=>"2",
      :constitution=>"3",
      :wisdom=>"1",
      :charisma=>"4",
      :intelligence=>"0",
      :spell1=>"branding-smite",
      :spell2=>"branding-smite",
      :spell3=>"branding-smite",
      :hit_points=>"65",
      :armor_class=>"20",
      :damage_die=>"1d8"
    }

    wizard = {
      :class=>"Wizard",
      :level=>"20",
      :strength=>"0",
      :dexterity=>"4",
      :constitution=>"3",
      :wisdom=>"2",
      :charisma=>"1",
      :intelligence=>"5",
      :spell1=>"fireball",
      :spell2=>"scorching-ray",
      :spell3=>"magic-missile",
      :hit_points=>"45",
      :armor_class=>"17",
      :damage_die=>"2d10"
    }
    data = [barbarian, rogue, monk, paladin, wizard]
    players = data.map do |player|
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
      PlayerCharacter.make_character(player)
    end
    monster = DndFacade.new.monster("adult-black-dragon")
    new_sim = Simulation.create(user_id: 1)
    (15).times do
      sim_runner = Sim.new(new_sim.id)
      sim_runner.roll_initiative(players, [monster])
    end
    # require 'pry'; binding.pry
  end
end