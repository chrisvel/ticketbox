class RemoveObsoleteTablesFromLegacyDb < ActiveRecord::Migration
  
  def up
    drop_table :auth_group
    drop_table :auth_group_permissions
    drop_table :auth_permission
    drop_table :auth_user
    drop_table :auth_user_groups
    drop_table :auth_user_user_permissions
    drop_table :django_admin_log
    drop_table :django_content_type
    drop_table :django_session
    drop_table :south_migrationhistory
  end
  
end
