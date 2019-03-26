class ChangeColumnToCourses < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :description, :text
  end
end
