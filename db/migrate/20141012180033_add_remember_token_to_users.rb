class AddRememberTokenToUsers < ActiveRecord::Migration
  
  def change
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end
  
  def down
    remove_index :users, :remember_token
    remove_column :users, :remember_token
  end

end
