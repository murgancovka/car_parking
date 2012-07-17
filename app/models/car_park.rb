class CarPark < ActiveRecord::Base
  belongs_to :gate
  has_one :payment
  
  attr_accessible :gate_id, :is_left

  scope :is_left, where("is_left = false")
  
  def self.search(search)
    search_condition = "%" + search + "%"
    if search
      #find(:all, :conditions => ['title LIKE ? or text LIKE ? ', search_condition, search_condition], :limit => 20)
    else
      #find :all
    end
  end
end
