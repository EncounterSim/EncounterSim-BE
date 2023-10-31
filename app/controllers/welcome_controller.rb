class WelcomeController < ApplicationController

  def index
    @monsters = DndFacade.new.monsters
  end
end