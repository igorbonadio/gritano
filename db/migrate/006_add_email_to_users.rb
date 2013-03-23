class AddEmailToUsers < ActiveRecord::Migration
  def up
    add_column :users, :email, :string, :default => false
  end
  
  def down
    remove_column :users, :email
  end
end

