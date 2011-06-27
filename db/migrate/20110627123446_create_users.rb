class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :encrypted_password, :limit => 128
      t.string    :salt,               :limit => 128
      t.string    :confirmation_token, :limit => 128
      t.string    :remember_token,     :limit => 128
      t.string    :first_name
      t.string    :last_name
      t.boolean   :active,              :default => true
      t.datetime  :confirmed_at
      t.string    :time_zone
      t.string    :phone_number
      t.string    :company_name
      t.string    :title
      t.string    :address_line_1
      t.string    :address_line_2
      t.string    :city
      t.string    :postal_code
      t.integer   :state_id
      t.integer   :country_id

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :remember_token
  end

  def self.down
    drop_table :users
  end
end
