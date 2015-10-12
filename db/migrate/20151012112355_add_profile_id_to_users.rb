class AddProfileIdToUsers < ActiveRecord::Migration

  change_table :users do |t|
    t.references :profile
  end

end
