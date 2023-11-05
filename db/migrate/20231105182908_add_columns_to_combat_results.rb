class AddColumnsToCombatResults < ActiveRecord::Migration[7.1]
  def change
    add_column :combat_results, :p1_attacks_attempted, :integer
    add_column :combat_results, :p1_attacks_successful, :integer
    add_column :combat_results, :p1_attacks_against_me, :integer
    add_column :combat_results, :p1_attacks_hit_me, :integer
    add_column :combat_results, :p2_attacks_attempted, :integer
    add_column :combat_results, :p2_attacks_successful, :integer
    add_column :combat_results, :p2_attacks_against_me, :integer
    add_column :combat_results, :p2_attacks_hit_me, :integer
    add_column :combat_results, :p3_attacks_attempted, :integer
    add_column :combat_results, :p3_attacks_successful, :integer
    add_column :combat_results, :p3_attacks_against_me, :integer
    add_column :combat_results, :p3_attacks_hit_me, :integer
    add_column :combat_results, :p4_attacks_attempted, :integer
    add_column :combat_results, :p4_attacks_successful, :integer
    add_column :combat_results, :p4_attacks_against_me, :integer
    add_column :combat_results, :p4_attacks_hit_me, :integer
    add_column :combat_results, :p5_attacks_attempted, :integer
    add_column :combat_results, :p5_attacks_successful, :integer
    add_column :combat_results, :p5_attacks_against_me, :integer
    add_column :combat_results, :p5_attacks_hit_me, :integer
    add_column :combat_results, :monster_attacks_attempted, :integer
    add_column :combat_results, :monster_attacks_successful, :integer
    add_column :combat_results, :monster_attacks_against_me, :integer
    add_column :combat_results, :monster_attacks_hit_me, :integer
  end
end
