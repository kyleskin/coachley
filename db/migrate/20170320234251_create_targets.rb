class CreateTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :targets do |t|
      t.string :objective
      t.string :text
      t.string :due_date
      t.string :string
      t.string :expected_result
      t.string :text
      t.boolean :current
      t.string :type

      t.timestamps
    end
  end
end
