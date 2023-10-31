require 'rails_helper'

RSpec.describe DndService do
  it 'exists' do
    ds = DndService.new
    expect(ds).to be_a DndService
  end

  describe 'class methods' do
    it '#monsters', :vcr do
      results = DndService.new.monsters

      expect(results).to be_a Hash
      expect(results[:results]).to be_an Array
      expect(results[:results][0][:name]).to be_a String
      expect(results[:results][0][:url]).to be_a String
    end
    it '#spells', :vcr do
      results = DndService.new.spells

      expect(results).to be_a Hash
      expect(results[:results]).to be_an Array
      expect(results[:results][0][:name]).to be_a String
      expect(results[:results][0][:url]).to be_a String
    end
    it '#players', :vcr do
      results = DndService.new.players

      expect(results).to be_a Hash
      expect(results[:results]).to be_an Array
      expect(results[:results][0][:name]).to be_a String
      expect(results[:results][0][:url]).to be_a String
    end
  end
end