require 'rails_helper'

RSpec.describe Simulation, type: :model do
  it { should have_many(:combats) }
  it { should have_many(:combat_results).through(:combats) }
  it { should have_many(:combat_rounds).through(:combats) }
end