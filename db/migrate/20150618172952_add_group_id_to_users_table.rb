class AddGroupIdToUsersTable < ActiveRecord::Migration
  
  def up
    add_column :users, :group_id, :integer
    add_foreign_key :users, :groups, index: true
  end
  
  def down 
    remove_foreign_key :users, :groups
    remove_column :users, :group_id
  end
  
end
