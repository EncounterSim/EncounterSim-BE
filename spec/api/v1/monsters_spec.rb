require 'rails_helper'

RSpec.describe "Monsters Endpoint" do
  before :each do 
    load_test_data
  end
  describe "Monsters Index endpoint" do
    it "returns JSON data for all monsters pulled from API", :vcr do
      
      get "/api/v1/monsters"

      expect(response).to be_successful

      monsters = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(monsters.first[:attributes]).to have_key(:url)
      expect(monsters.first[:attributes][:url]).to be_a(String)

      expect(monsters.first[:attributes]).to have_key(:name)
      expect(monsters.first[:attributes][:name]).to be_a(String)

      expect(monsters.first[:attributes]).to have_key(:index)
      expect(monsters.first[:attributes][:index]).to be_a(String)
    end
  end

  describe "Show endpoint" do
    it "Gives data on a singular monster", :vcr do

      get "/api/v1/monsters/aboleth"

      expect(response).to be_successful

      monster = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(monster).to be_a Hash
      expect(monster).to have_key :id

      expect(monster).to have_key :attributes
      expect(monster[:attributes]).to be_a Hash
      attributes = monster[:attributes]

      expect(attributes).to have_key :name
      expect(attributes).to have_key :armor_class
      expect(attributes).to have_key :hit_points
      expect(attributes).to have_key :strength
      expect(attributes).to have_key :dexterity
      expect(attributes).to have_key :constitution
      expect(attributes).to have_key :intelligence
      expect(attributes).to have_key :wisdom
      expect(attributes).to have_key :charisma
      expect(attributes).to have_key :attacks
    end
  end
end