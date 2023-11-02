require 'rails_helper'

RSpec.describe CombatRound, type: :model do
  it { should belong_to(:combat) }
end