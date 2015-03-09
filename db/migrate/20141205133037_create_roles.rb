class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :level
      t.integer :user_id
      t.integer :group_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
