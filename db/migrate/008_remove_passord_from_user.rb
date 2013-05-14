class RemovePasswordFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :crypted_password
  end
  
  def down
    add_column :users, :crypted_password, :string, :default => nil
  end
end

