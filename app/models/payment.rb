class Payment < ActiveRecord::Base
  belongs_to :car_park
  
  attr_accessible :car_park_id#, :how_much
  
  scope :is_paid, where("is_paid = true")
end
