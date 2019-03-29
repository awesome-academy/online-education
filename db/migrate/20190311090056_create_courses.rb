class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :overview_video_url
      t.integer :price
      t.string :duration
      t.integer :course_status
      t.text :employment_conditions

      t.timestamps
    end
  end
end
