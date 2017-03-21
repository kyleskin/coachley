class FixTargetColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :targets, :text
    remove_column :targets, :string
    remove_column :targets, :objective
    remove_column :targets, :expected_result

    add_column :targets, :objective, :text
    add_column :targets, :expected_result, :text
  end
end
