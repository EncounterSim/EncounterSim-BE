class CreateCombat < ActiveRecord::Migration[7.1]
  def change
    create_table :combats do |t|
      t.references :simulation, null: false, foreign_key: true
      t.string :p1
      t.string :p2
      t.string :p3
      t.string :p4
      t.string :p5
      t.string :monster

      t.timestamps
    end
  end
end
