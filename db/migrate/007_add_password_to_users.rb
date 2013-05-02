class AddPasswordToUsers < ActiveRecord::Migration
  def up
    add_column :users, :crypted_password, :string, :default => nil
  end
  
  def down
    remove_column :users, :crypted_password
  end
end

