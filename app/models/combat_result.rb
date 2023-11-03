class CombatResult < ApplicationRecord
  belongs_to :combat
  enum outcome: {
    "Win" => 0,
    "Lose" => 1
  }
end