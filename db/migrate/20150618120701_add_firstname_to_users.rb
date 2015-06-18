class AddFirstnameToUsers < ActiveRecord::Migration
 
  def up
    add_column :users, :firstname, :string, limit: 100
    add_column :users, :lastname, :string, limit: 100
    add_column :users, :username, :string, limit: 18
  end
  
  def down
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :username
  end
  
end
