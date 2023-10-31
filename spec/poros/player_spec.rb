require 'rails_helper'

RSpec.describe Player do
  it "exists" do
    attrs = {
      id: nil,
      name: "Player 1",
      url: "/api/classes/player-1"
    }

    player = Player.new(attrs)

    expect(player).to be_a Player
    expect(player.id).to be nil
    expect(player.name).to eq("Player 1")
    expect(player.url).to eq("/api/classes/player-1")
  end
end