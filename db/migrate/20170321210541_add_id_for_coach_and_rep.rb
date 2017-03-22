class AddIdForCoachAndRep < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coach_id, :integer
    add_column :users, :rep_id, :integer
  end
end
