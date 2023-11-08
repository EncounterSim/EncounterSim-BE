require 'rails_helper'

RSpec.describe SimMonster do
  describe "It exists" do
    before :each do 
      @monster = DndFacade.new.monster("ancient-black-dragon")
    end

    it "Has readable attributes", :vcr do
      expect(@monster.id).to be 6
      expect(@monster.name).to eq("Ancient Black Dragon")
      expect(@monster.armor_class).to eq(22)
      expect(@monster.hit_points).to eq(367)
      expect(@monster.strength).to eq(8)
      expect(@monster.dexterity).to eq(2)
      expect(@monster.constitution).to eq(7)
      expect(@monster.intelligence).to eq(3)
      expect(@monster.wisdom).to eq(2)
      expect(@monster.charisma).to eq(4)
      expect(@monster.proficiencies).to be_an Array
      expect(@monster.proficiencies[0]).to be_a Hash
      expect(@monster.prof_bonus).to eq(7)
      expect(@monster.special_abilities).to be_an Array
      expect(@monster.special_abilities[0]).to be_a Hash
      expect(@monster.attacks).to be_an Array
      expect(@monster.attacks[0]).to be_an Attack
      expect(@monster.damage_dealt).to eq(0)
      expect(@monster.attacks_attempted).to eq(0)
      expect(@monster.attacks_successful).to eq(0)
      expect(@monster.attacks_against_me).to eq(0)
      expect(@monster.attacks_hit_me).to eq(0)
      expect(@monster.image).to be_a String
    end

    it "#determine_action", :vcr do
      expect(@monster.determine_action).to be_an Array
      expect(@monster.determine_action[0]).to  have_key(:attack)
      expect(@monster.determine_action[0][:attack].name).to eq("Acid Breath").or eq("Bite")
      expect(@monster.determine_action[0]).to have_key(:count)
    end

    it "#damage_output", :vcr do
      expect(@monster.attacks_successful).to eq(0)
      expect(@monster.damage_dealt).to eq(0)
      @monster.damage_output(5)
      
      expect(@monster.attacks_successful).to eq(1)
      expect(@monster.damage_dealt).to eq(5)
    end

    it "#reset_damage_dealt", :vcr do
      @monster.damage_output(5)
      expect(@monster.damage_dealt).to eq(5)
      @monster.reset_damage_dealt
      
      expect(@monster.damage_dealt).to eq(0)
    end

    it "#attempt_hit", :vcr do
      expect(@monster.attacks_attempted).to eq(0)
      @monster.attempt_hit
      
      expect(@monster.attacks_attempted).to eq(1)
    end

    it "#missed_me", :vcr do
      expect(@monster.attacks_against_me).to eq(0)
      @monster.missed_me
      
      expect(@monster.attacks_against_me).to eq(1)
    end

    it "#take_damage", :vcr do
      expect(@monster.attacks_against_me).to eq(0)
      expect(@monster.attacks_hit_me).to eq(0)
      expect(@monster.hit_points).to eq(367)
      @monster.take_damage(7)

      expect(@monster.attacks_against_me).to eq(1)
      expect(@monster.attacks_hit_me).to eq(1)
      expect(@monster.hit_points).to eq(360)
    end

    it "#saving_throw", :vcr do
      expect(@monster.saving_throw("con")).to eq(14)
    end
  end
end