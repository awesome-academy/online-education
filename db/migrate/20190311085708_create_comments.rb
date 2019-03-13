class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.integer :commentable_type
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
