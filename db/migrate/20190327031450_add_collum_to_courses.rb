class AddCollumToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :course_status, :integer
    add_column :courses, :employment_conditions, :text
  end
end
