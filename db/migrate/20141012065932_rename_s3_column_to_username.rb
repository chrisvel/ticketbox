class RenameS3ColumnToUsername < ActiveRecord::Migration
  
  def up
    rename_column :users, :s3, :username
  end
  
end
