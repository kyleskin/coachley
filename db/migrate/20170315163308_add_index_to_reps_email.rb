class AddIndexToRepsEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :reps, :email, unique: true
  end
end
