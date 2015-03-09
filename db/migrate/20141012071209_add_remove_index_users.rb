class AddRemoveIndexUsers < ActiveRecord::Migration
  
  def up
    # remove_index :users, :name => 'users_cb902d83'
    # add_index :users, :email, unique: true
  end

end
