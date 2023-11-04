class CreateCombatResult < ActiveRecord::Migration[7.1]
  def change
    create_table :combat_results do |t|
      t.references :combat, null: false, foreign_key: true
      t.integer :outcome

      t.timestamps
    end
  end
end
