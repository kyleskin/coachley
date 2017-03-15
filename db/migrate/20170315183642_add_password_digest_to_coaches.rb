class AddPasswordDigestToCoaches < ActiveRecord::Migration[5.0]
  def change
    add_column :coaches, :password_digest, :string
  end
end
