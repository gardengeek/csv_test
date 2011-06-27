class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :country_code, :limit => 2
      t.string :code, :limit => 2
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end
