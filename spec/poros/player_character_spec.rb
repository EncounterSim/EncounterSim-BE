require 'rails_helper'

RSpec.describe PlayerCharacter do
  before :each do 
    load_test_data
  end
  describe "It exists" do
    it "Is a PlayerCharacter" do
      expect(@gronk).to be_a PlayerCharacter
    end

    it "can accept and read its attributes" do
      expect(@gronk.level).to eq(3)
      expect(@gronk.name).to eq("Gronk")
      expect(@gronk.hit_points).to eq(12)
      expect(@gronk.armor_class).to eq(14)
      expect(@gronk.damage_die).to eq("1d10")
      expect(@gronk.strength).to eq(16)
      expect(@gronk.dexterity).to eq(15)
      expect(@gronk.constitution).to eq(16)
      expect(@gronk.intelligence).to eq(10)
      expect(@gronk.wisdom).to eq(8)
      expect(@gronk.charisma).to eq(8)
    end
  end

  describe "class methods" do
    it "#make_character", :vcr do
      create_player_data("Barbarian")
      barbarian = PlayerCharacter.make_character(@player_data)
      create_player_data("Bard")
      bard = PlayerCharacter.make_character(@player_data)
      create_player_data("Cleric")
      cleric = PlayerCharacter.make_character(@player_data)
      create_player_data("Druid")
      druid = PlayerCharacter.make_character(@player_data)
      create_player_data("Fighter")
      fighter = PlayerCharacter.make_character(@player_data)
      create_player_data("Monk")
      monk = PlayerCharacter.make_character(@player_data)
      create_player_data("Paladin")
      paladin = PlayerCharacter.make_character(@player_data)
      create_player_data("Ranger")
      ranger = PlayerCharacter.make_character(@player_data)
      create_player_data("Rogue")
      rogue = PlayerCharacter.make_character(@player_data)
      create_player_data("Sorcerer")
      sorcerer = PlayerCharacter.make_character(@player_data)
      create_player_data("Warlock")
      warlock = PlayerCharacter.make_character(@player_data)
      create_player_data("Wizard")
      wizard = PlayerCharacter.make_character(@player_data)


      expect(barbarian).to be_a SimBarbarian
      expect(bard).to be_a SimBard
      expect(cleric).to be_a SimCleric
      expect(druid).to be_a SimDruid
      expect(fighter).to be_a SimFighter
      expect(monk).to be_a SimMonk
      expect(paladin).to be_a SimPaladin
      expect(ranger).to be_a SimRanger
      expect(rogue).to be_a SimRogue
      expect(sorcerer).to be_a SimSorcerer
      expect(warlock).to be_a SimWarlock
      expect(wizard).to be_a SimWizard
    end
  end

  describe "instance methods" do
    before :each do
      create_player_data("Warlock")
      @warlock = PlayerCharacter.make_character(@player_data)
    end

    it "#damage_output", :vcr do
      expect(@warlock.attacks_successful).to eq(0)
      expect(@warlock.damage_dealt).to eq(0)
      @warlock.damage_output(5)
      
      expect(@warlock.attacks_successful).to eq(1)
      expect(@warlock.damage_dealt).to eq(5)
    end

    it "#attempt_hit", :vcr do
      expect(@warlock.attacks_attempted).to eq(0)
      @warlock.attempt_hit
      
      expect(@warlock.attacks_attempted).to eq(1)
    end

    it "#missed_me", :vcr do
      expect(@warlock.attacks_against_me).to eq(0)
      @warlock.missed_me
      
      expect(@warlock.attacks_against_me).to eq(1)
    end

    it "#take_damage", :vcr do
      expect(@warlock.attacks_against_me).to eq(0)
      expect(@warlock.attacks_hit_me).to eq(0)
      expect(@warlock.hit_points).to eq(65)
      @warlock.take_damage(7)

      expect(@warlock.attacks_against_me).to eq(1)
      expect(@warlock.attacks_hit_me).to eq(1)
      expect(@warlock.hit_points).to eq(58)
    end

    it "#reset_damage_dealt", :vcr do
      @warlock.damage_output(5)
      expect(@warlock.damage_dealt).to eq(5)
      @warlock.reset_damage_dealt
      
      expect(@warlock.damage_dealt).to eq(0)
    end

    it "#best_attack", :vcr do
      expect(@warlock.best_attack).to be_an Array
      expect(@warlock.best_attack[0]).to  have_key(:attack)
      expect(@warlock.best_attack[0]).to  have_key(:count)
    end

    it "#determine_action", :vcr do
      expect(@warlock.determine_action).to be_an Array
      expect(@warlock.determine_action[0]).to  have_key(:attack)
      expect(@warlock.determine_action[0]).to  have_key(:count)
    end

    it "#melee_attack", :vcr do
      expect(@warlock.melee_attack).to be_an Array
      expect(@warlock.melee_attack[0]).to  have_key(:attack)
      expect(@warlock.melee_attack[0]).to  have_key(:count)
    end

    it "#cantrip", :vcr do
      expect(@warlock.cantrip).to be_an Array
      expect(@warlock.cantrip[0]).to  have_key(:attack)
      expect(@warlock.cantrip[0]).to  have_key(:count)
    end

    it "#spell_to_hit", :vcr do
      expect(@warlock.spell_to_hit).to eq(5)
    end

    it "#cast_level", :vcr do
      expect(@warlock.spellcasting[:spell_slots_level_5]).to eq(4)
      expect(@warlock.cast_level).to eq("5")
      
      expect(@warlock.spellcasting[:spell_slots_level_5]).to eq(3)
    end

    it "#get_spell_slot", :vcr do
    expect(@warlock.get_spell_slot).to eq("5")
    end

    it "#spell_count", :vcr do
      expect(@warlock.spell_count).to eq(4)
      expect(@warlock.cast_level).to eq("5")
      expect(@warlock.spell_count).to eq(3)
    end

    it "#count_resources", :vcr do
      expect(@warlock.count_resources).to eq(4)
      expect(@warlock.cast_level).to eq("5")
      expect(@warlock.count_resources).to eq(3)
    end

    it "#spell_save_dc", :vcr do
      expect(@warlock.spell_save_dc).to eq(19)
    end

    it "#saving_throw", :vcr do
      expect(@warlock.saving_throw("con")).to eq(5)
    end
  end
end