require 'rails_helper'

RSpec.describe Monster do
  it "exists" do
    attrs = {
      id: nil,
      name: "Monster 1",
      url: "/api/monsters/monster-1"
    }

    monster = Monster.new(attrs)

    expect(monster).to be_a Monster
    expect(monster.id).to be nil
    expect(monster.name).to eq("Monster 1")
    expect(monster.url).to eq("/api/monsters/monster-1")
  end
end