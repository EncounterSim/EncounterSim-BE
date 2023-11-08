require 'rails_helper'

RSpec.describe "Players enpoint" do
  describe "Index enpoint" do
    it "returns list of player classes", :vcr do

      get "/api/v1/players"

      expect(response).to be_successful

      players = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(players.first).to have_key :attributes
      attributes = players.first[:attributes]

      expect(attributes).to have_key :name
      expect(attributes).to have_key :index
      expect(attributes).to have_key :url
    end
  end
end