class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :person
      t.text :addr_1

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
