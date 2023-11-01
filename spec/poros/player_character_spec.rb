require 'rails_helper'

RSpec.describe PlayerCharacter do
  before :each do 
    load_test_data
  end
  describe "It exists" do
    it "Is a SimBarbarian" do
      expect(@gronk).to be_a PlayerCharacter
    end
  end
  describe "Attributes" do
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
end