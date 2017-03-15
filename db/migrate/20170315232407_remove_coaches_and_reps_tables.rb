class RemoveCoachesAndRepsTables < ActiveRecord::Migration[5.0]
  def up
    drop_table :reps
    drop_table :coaches
  end
end
