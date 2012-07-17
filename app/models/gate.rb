class Gate < ActiveRecord::Base
  #has_many :car_parks
  
  scope :is_enabled, where("is_enabled = true")
end
