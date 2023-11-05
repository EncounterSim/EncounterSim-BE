class Result
  attr_reader :id, :total_wins, :total_loses

  def initialize(sim_id)
    @id = sim_id
    @total_wins = total_wins
    @total_loses = total_loses
  end

  def total_wins
    Simulation.last.combat_results.where(outcome: "Win").count
  end

  def total_loses
    Simulation.last.combat_results.where(outcome: "Lose").count
  end

  def total_combats
    require 'pry'; binding.pry
  end
end