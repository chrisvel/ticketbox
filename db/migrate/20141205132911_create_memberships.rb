class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.string :typeof
      t.integer :user_id
      t.integer :group_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
