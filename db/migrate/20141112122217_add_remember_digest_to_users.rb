class AddRememberDigestToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :remember_digest, :string
  end
  
  def down
    remove_column :users, :remember_digest
  end
  
end
