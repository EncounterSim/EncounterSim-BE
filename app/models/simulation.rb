class Simulation < ApplicationRecord
  has_many :combats
  has_many :combat_results, through: :combats
  has_many :combat_rounds, through: :combats
end