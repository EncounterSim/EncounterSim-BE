class Player
  attr_reader :id, :name, :url

  def initialize(info)
    @id = nil
    @index = info[:index]
    @name = info[:name]
    @url = info[:url]
  end
end