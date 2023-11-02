require 'rails_helper'

RSpec.describe Combat, type: :model do
  it { should belong_to(:simulation) }
  it { should have_many(:combat_results) }
  it { should have_many(:combat_rounds) }
end