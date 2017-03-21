class TargetCurrentDefaultTrue < ActiveRecord::Migration[5.0]
  def change
    change_column :targets, :current, :boolean, default: true
  end
end
