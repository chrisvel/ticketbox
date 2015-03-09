class AddActivationToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
  end
  
  def down
    remove_column :users, :activated_at
    remove_column :users, :activated
    remove_column :users, :activation_digest
  end
  
end
