require 'rails_helper'

RSpec.describe CombatResult, type: :model do
  it { should belong_to(:combat) }
end