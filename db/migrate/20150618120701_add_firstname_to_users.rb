class AddFirstnameToUsers < ActiveRecord::Migration

  def up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :username, :string
  end

  def down
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :username
  end

end
