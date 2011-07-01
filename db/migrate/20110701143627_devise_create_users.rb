class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_created_at, :datetime

    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    remove_column :users, :confirmation_sent_at
    remove_column :users, :reset_password_token
    remove_column :users, :remember_created_at
    remove_index :users, :reset_password_token
  end
end
