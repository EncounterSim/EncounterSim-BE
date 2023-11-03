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
    player = @service.player(index)
    if index == "barbarian"
      SimBarbarian.new(player)
    elsif index == "bard"
      SimBard.new(player)
    elsif index == "cleric"
      SimCleric.new(player)
    elsif index == "druid"
      SimDruid.new(player)
    elsif index == "fighter"
      SimFighter.new(player)
    elsif index == "monk"
      SimMonk.new(player)
    elsif index == "paladin"
      SimPaladin.new(player)
    elsif index == "ranger"
      SimRanger.new(player)
    elsif index == "rogue"
      SimRogue.new(player)
    elsif index == "sorcerer"
      SimSorcerer.new(player)
    elsif index == "warlock"
      SimWarlock.new(player)
    elsif index == "wizard"
      SimWizard.new(player)
    end
  end
    
end