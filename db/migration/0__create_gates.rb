class CreateGate < ActiveRecord::Migration
  def self.up
    create_table :gates do |t|
      t.string   :name
      t.boolean  :is_enabled
      
      t.timestamps
    end
  end
 
  def self.down
    drop_table :gates
  end
end
