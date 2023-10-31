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
  end
end