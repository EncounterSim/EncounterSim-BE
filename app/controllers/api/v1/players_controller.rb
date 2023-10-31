class Api::V1::PlayersController < ApplicationController

  def index
    render json: PlayerSerializer.new(DndFacade.new.players)
  end

end