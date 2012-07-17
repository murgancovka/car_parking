class CreateCarPark < ActiveRecord::Migration
  def self.up
    create_table :car_parks do |t|
      t.references :gate
      t.string   :name
      t.boolean  :is_left
      t.date     :left_at
      t.boolean  :is_late_to_pay
      
      t.timestamps
    end
  end
 
  def self.down
    drop_table :car_parks
  end
end
