class Api::V1::EncountersController < ApplicationController

  def encounters
    @facade = DndFacade.new
  end
end