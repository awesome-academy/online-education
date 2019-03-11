class CreatePurchasedCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_courses do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :money_spend

      t.timestamps
    end
  end
end
