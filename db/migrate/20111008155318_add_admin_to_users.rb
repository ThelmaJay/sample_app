class AddAdminToUsers < ActiveRecord::Migration
#:default => false means that the users will not be adminstrators by default
  def self.up
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin
  end
end
