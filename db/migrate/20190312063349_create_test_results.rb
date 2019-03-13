class CreateTestResults < ActiveRecord::Migration[5.2]
  def change
    create_table :test_results do |t|
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end
end
