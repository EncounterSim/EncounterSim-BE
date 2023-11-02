class Combat < ApplicationRecord
  belongs_to :simulation
  has_many :combat_results
  has_many :combat_rounds
end