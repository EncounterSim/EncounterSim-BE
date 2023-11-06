require 'rails_helper'

RSpec.describe SimMonk do
  describe "Sim differences" do
    before :each do 
      create_player_data("Monk")
      @monk = PlayerCharacter.make_character(@player_data)
    end

    it "Inherits from PlayerCharacter", :vcr do
      expect(@monk).to be_a PlayerCharacter
    end

    it "#take_damage", :vcr do
      expect(@monk.count_resources).to eq(20)
    end
  end
end