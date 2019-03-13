class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.string :integer
      t.integer :test_result_id
      t.integer :question_id
      t.integer :user_choice
      t.boolean :correct

      t.timestamps
    end
  end
end
