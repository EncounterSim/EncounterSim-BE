require 'rails_helper'

RSpec.describe "Spells enpoint" do
  describe "Index enpoint" do
    it "returns list of Spells", :vcr do

      get "/api/v1/spells"

      expect(response).to be_successful
      spells = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(spells.first).to have_key :attributes
      spell = spells.first[:attributes]

      expect(spell).to have_key :name
      expect(spell).to have_key :url
    end
  end
end