class SimSpell
  attr_reader :index, :duration, :casting_time, :level,
              :damage, :saving_throw, :aoe

  def initialize(data)
    @index = data[:index]
    @duration = data[:duration]
    @casting_time = data[:casting_time]
    @level = data[:level]
    @damage = data[:damage][:damage_at_slot_level]
    @saving_throw = {
      type: data[:dc][:dc_type][:index], 
      dc_success: data[:dc][:dc_success]
    } if data[:dc]
    @aoe = data[:area_of_effect] if data[:area_of_effect]
  end
end