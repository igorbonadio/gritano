class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :repository_id
      t.integer :access
      t.timestamps
    end
  end
end
