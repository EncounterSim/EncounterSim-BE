class SimWarlock < PlayerCharacter

  def initialize(data)
    super
    @resources = spell_count
  end

end