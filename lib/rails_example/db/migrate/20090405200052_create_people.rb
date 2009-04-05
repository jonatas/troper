class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :phone, :limit => 20
      t.timestamps
    end

    Person.create(:name => "Jônatas Davi Paganini", 
                  :email => "jonatasdp@gmail.com",
                  :phone => "46 9911 7879")

    Person.create(:name => "Peter Pan", 
                  :email => "peter@pan.net",
                  :phone => "46 8822 8800")

  end

  def self.down
    drop_table :people
  end
end
