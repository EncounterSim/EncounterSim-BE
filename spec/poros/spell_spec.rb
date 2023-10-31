require 'rails_helper'

RSpec.describe Spell do
  it "exists" do
    attrs = {
      id: nil,
      name: "Spell 1",
      url: "/api/spells/spell-1"
    }

    spell = Spell.new(attrs)

    expect(spell).to be_a Spell
    expect(spell.id).to be nil
    expect(spell.name).to eq("Spell 1")
    expect(spell.url).to eq("/api/spells/spell-1")
  end
end