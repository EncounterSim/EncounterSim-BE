require 'rails_helper'

RSpec.describe DndFacade, test: :model do
  it 'exists' do
    df = DndFacade.new

    expect(df).to be_a DndFacade
  end

  describe 'instance methods' do
    it '#monsters', :vcr do
      monsters = DndFacade.new.monsters

      expect(monsters).to all be_a Monster
      monsters.each do |monster|
        expect(monster.id).to be nil
        expect(monster.name).to be_a String
        expect(monster.url).to be_a String
      end
    end

    it '#spells', :vcr do
      spells = DndFacade.new.spells

      expect(spells).to all be_a Spell
      spells.each do |spell|
        expect(spell.id).to be nil
        expect(spell.name).to be_a String
        expect(spell.url).to be_a String
      end
    end

    it '#players', :vcr do
      players = DndFacade.new.players

      expect(players).to all be_a Player
      players.each do |player|
        expect(player.id).to be nil
        expect(player.name).to be_a String
        expect(player.url).to be_a String
      end
    end

    it "#monster", :vcr do
      monster = DndFacade.new.monster("adult-black-dragon")
      expect(monster).to be_a SimMonster
      expect(monster.name).to be_a String
      expect(monster.armor_class).to be_a Integer
      expect(monster.hit_points).to be_a Integer
      expect(monster.strength).to be_a Integer
      expect(monster.dexterity).to be_a Integer
      expect(monster.constitution).to be_a Integer
      expect(monster.intelligence).to be_a Integer
      expect(monster.wisdom).to be_a Integer
      expect(monster.charisma).to be_a Integer
      expect(monster.proficiencies).to be_an Array
      expect(monster.prof_bonus).to be_a Integer
      expect(monster.special_abilities).to be_an Array
      expect(monster.attacks).to be_an Array
      expect(monster.damage_dealt).to be_a Integer
      expect(monster.attacks_attempted).to be_a Integer
      expect(monster.attacks_successful).to be_a Integer
      expect(monster.attacks_against_me).to be_a Integer
      expect(monster.attacks_hit_me).to be_a Integer
      expect(monster.image).to be_a String
    end

    it "#spell", :vcr do
      spell = DndFacade.new.spell('lightning-bolt')
      expect(spell).to be_a SimSpell
      expect(spell.index).to be_a String
      expect(spell.duration).to be_a String
      expect(spell.casting_time).to be_a String
      expect(spell.level).to be_a Integer
      expect(spell.damage).to be_a Hash
      expect(spell.saving_throw).to be_a Hash
      expect(spell.aoe).to be_a Hash
    end

    it "#player", :vcr do
      player = DndFacade.new.player("barbarian")
      expect(player).to be_an Array
      expect(player.count).to eq(20)
      expect(player[0]).to have_key(:level)
      expect(player[0]).to have_key(:prof_bonus)
      expect(player[0]).to have_key(:features)
      expect(player[0]).to have_key(:class_specific)
    end
  end
end