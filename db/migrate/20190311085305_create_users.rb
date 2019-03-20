class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.datetime :birthday
      t.integer :balance
      t.integer :user_type, default: 0
      t.string :avatar_url
      t.string :phone
      t.string :position
      t.string :description

      t.timestamps
    end
  end
end
