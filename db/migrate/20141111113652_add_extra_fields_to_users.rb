class AddExtraFieldsToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :time_zone, :string, :limit => 255, :default => "UTC"
    add_column :users, :department, :string, :limit => 255
    add_column :users, :position, :string, :limit => 255
    add_column :users, :landline_phone, :string, :limit => 255
    add_column :users, :mobile_phone, :string, :limit => 255
  end
  
  def down
    remove_column :users, :mobile_phone
    remove_column :users, :landline_phone
    remove_column :users, :position
    remove_column :users, :department
    remove_column :users, :time_zone  
  end
  
end
