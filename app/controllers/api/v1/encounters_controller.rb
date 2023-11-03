class Api::V1::EncountersController < ApplicationController

  def create
    data = JSON.parse(request.body.read, symbolize_names: true)
    players = parse_players(params[:characters])
    monster_name = parse_monster_name(params[:monster])
    monster = DndFacade.new.monster(monster_name)
  end

  private

  def parse_monster_name(name)
    name.downcase.gsub(" ", "-")
  end

  def parse_players(players_hash)
    players_hash.each do |player|
      player[:damage_die] = "#{player[:damage_die1]}"+"#{player[:damage_die2]}"
    end
    players_hash.map do |player|
      PlayerCharacter.make_character(player)
    end
  end
end