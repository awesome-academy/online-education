class CreateTrainerCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :trainer_candidates do |t|
      t.integer :user_id
      t.string :introduce
      t.integer :course_id
      t.string :cv_url
      t.string :integer

      t.timestamps
    end
  end
end
