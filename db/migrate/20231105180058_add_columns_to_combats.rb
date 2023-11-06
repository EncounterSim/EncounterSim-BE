class AddColumnsToCombats < ActiveRecord::Migration[7.1]
  def change
    add_column :combats, :p1_initiative, :integer
    add_column :combats, :p2_initiative, :integer
    add_column :combats, :p3_initiative, :integer
    add_column :combats, :p4_initiative, :integer
    add_column :combats, :p5_initiative, :integer
    add_column :combats, :monster_initiative, :integer
  end
end
