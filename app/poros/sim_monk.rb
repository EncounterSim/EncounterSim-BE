class SimMonk < PlayerCharacter

  def initialize(data)
    super
    @resources = data[:class_specific][:ki_points]
  end

  def count_resources
    resources = 0
    super
    resources += @resources
  end

end