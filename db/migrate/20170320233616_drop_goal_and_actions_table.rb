class DropGoalAndActionsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :goal_and_actions
  end
end
