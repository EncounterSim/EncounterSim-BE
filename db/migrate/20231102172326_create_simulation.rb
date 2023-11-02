class CreateSimulation < ActiveRecord::Migration[7.1]
  def change
    create_table :simulations do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
