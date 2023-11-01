class Attack

  def initialize(data)
    @name = data[:name]
    @description = data[:desc]
    @action = data[:actions]
    @hit_bonus = data[:attack_bonus]
    @saving_throw = {
      type: data[:dc][:name], 
      threshold: data[:dc][:dc_value], 
      success: data[:dc][:success_type]
    } if data[:dc]
    @damage_dice = data[:damage] if data[:damage]
  end
end