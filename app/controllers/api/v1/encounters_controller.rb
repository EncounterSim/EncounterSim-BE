class Api::V1::EncountersController < ApplicationController

  def create
    data = JSON.parse(request.body.read, symbolize_names: true)
    players = parse_players(params[:characters])
    monster_name = index_name(params[:monster])
    monster = DndFacade.new.monster(monster_name)
    Simulation.create!(user_id: params[:user_id])
    # add 50 times loop for more combats
    Sim.new.roll_initiative(players, [monster])
    require 'pry'; binding.pry
    # Pry here to check simulation data
    # Simulation.last.combats.last.combat_results
    # Simulation.last.combats.last.combat_rounds
  end

  private

  def index_name(name)
    name.downcase.gsub(" ", "-")
  end

  def parse_players(players_hash)
    active_players = players_hash.select {|p| p[:hit_points] != ""}
    active_players.map do |player|
      level_info = DndFacade.new.player(player[:class].downcase)
      player[:damage_die] = "#{player[:damage_die1]}"+"#{player[:damage_die2]}"
      player[:prof_bonus] = level_info[player[:level].to_i - 1][:prof_bonus]
      player[:spells] = [DndFacade.new.spell(index_name(player[:spell1])), DndFacade.new.spell(index_name(player[:spell2])), DndFacade.new.spell(index_name(player[:spell3]))]
      player[:class_specific] = level_info[player[:level].to_i - 1][:class_specific]
      player[:features] = []
      index = 0
      while index <= (player[:level].to_i - 1)
        feat_names = level_info[index][:features].map { |each| each[:name] }
        player[:features].concat(feat_names)
        index += 1
      end
      PlayerCharacter.make_character(player)
    end
  end
end