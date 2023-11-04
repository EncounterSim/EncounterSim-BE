class DndFacade
  
  def initialize()
    @service = DndService.new
  end

  def monsters
    @service.monsters[:results].map do |monster|
      Monster.new(monster)
    end
  end

  def spells
    @service.spells[:results].map do |spell|
      Spell.new(spell)
    end
  end
  
  def players
    @service.players[:results].map do |player|
      Player.new(player)
    end
  end

  def monster(index)
    monster = @service.monster(index)
    SimMonster.new(monster)
  end

  def spell(index)
    spell = @service.spell(index)
    SimSpell.new(spell)
  end

  def player(index)
    @service.player(index)
  end
    
end