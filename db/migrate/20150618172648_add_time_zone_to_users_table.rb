class AddTimeZoneToUsersTable < ActiveRecord::Migration
  
  def up
    add_column :users, :time_zone, :string, null: false, default: "UTC"
  end
  
  def down 
    remove_column :users, :time_zone
  end
  
end
