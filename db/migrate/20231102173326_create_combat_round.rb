class CreateCombatRound < ActiveRecord::Migration[7.1]
  def change
    create_table :combat_rounds do |t|
      t.references :combat, null: false, foreign_key: true
      t.integer :p1_health
      t.integer :p1_resources
      t.integer :p1_damage_dealt
      t.integer :p2_health
      t.integer :p2_resources
      t.integer :p2_damage_dealt
      t.integer :p3_health
      t.integer :p3_resources
      t.integer :p3_damage_dealt
      t.integer :p4_health
      t.integer :p4_resources
      t.integer :p4_damage_dealt
      t.integer :p5_health
      t.integer :p5_resources
      t.integer :p5_damage_dealt
      t.integer :monster_health
      t.integer :monster_resources
      t.integer :monster_damage_dealt

      t.timestamps
    end
  end
end
