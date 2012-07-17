class CreatePayment < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.references :car_park
      t.integer  :how_much
      t.boolean  :is_paid
      t.boolean  :is_extra_money
      
      t.timestamps
    end
  end
 
  def self.down
    drop_table :payments
  end
end
