require 'rails_helper'

RSpec.describe SimBarbarian do
  describe "Sim differences" do
    before :each do 
      create_player_data("Barbarian")
      @barbarian = PlayerCharacter.make_character(@player_data)
    end

    it "Inherits from PlayerCharacter", :vcr do
      expect(@barbarian).to be_a PlayerCharacter
    end

    it "#take_damage", :vcr do
      expect(@barbarian.hit_points).to eq(65)
      @barbarian.take_damage(10)
      expect(@barbarian.hit_points).to eq(60)
    end
  end
end