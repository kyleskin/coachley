class AddUserIdToTargets < ActiveRecord::Migration[5.0]
  def change
    add_column :targets, :user_id, :integer
  end
end
