require 'rails_helper'

RSpec.describe Sim do
  it "works", :vcr do
    monster = DndFacade.new.monster("berserker")
    barb_data = {
      name: "Barbarian",
      level: 5,
      prof_bonus: 3,
      armor_class: 1,
      hit_points: 100,
      damage_die: "2d6",
      strength: 5,
      dexterity: 4,
      constitution: 4,
      intelligence: -1,
      wisdom: 2,
      charisma: 1
    }
    fight_data = {
      name: "Fighter",
      level: 5,
      prof_bonus: 3,
      armor_class: 1,
      hit_points: 80,
      damage_die: "1d8",
      strength: 4,
      dexterity: 5,
      constitution: 4,
      intelligence: 2,
      wisdom: 2,
      charisma: 2
    }
    sim1 = Simulation.create!(user_id: 1)
    player1 = SimBarbarian.new(barb_data)
    player2 = SimFighter.new(fight_data)
    game1 = Sim.new
    game1.roll_initiative([player1, player2], [monster])
    require 'pry'; binding.pry
  end
end