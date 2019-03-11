class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.string :name
      t.string :video_url

      t.timestamps
    end
  end
end
