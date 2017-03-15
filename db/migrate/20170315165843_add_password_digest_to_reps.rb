class AddPasswordDigestToReps < ActiveRecord::Migration[5.0]
  def change
    add_column :reps, :password_digest, :string
  end
end
