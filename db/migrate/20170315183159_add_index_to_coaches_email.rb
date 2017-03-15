class AddIndexToCoachesEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :coaches, :email, unique: true
  end
end
