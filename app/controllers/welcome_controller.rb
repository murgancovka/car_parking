class WelcomeController < ApplicationController
  protect_from_forgery
  
  layout 'application'
  
  def about
    @cars = CarPark.find(:all)
    
    if !@cars.empty?
      @time_start  = CarPark.find(:first).created_at
      @time_end    = CarPark.find(:last).created_at
    end
  end
  
  def admin
    @cars = CarPark.find(:all)
  end
  
  def destroy
    car = CarPark.find_by_id(params[:id])
    if car
      car.destroy
      flash[:success] = "Successfully deleted!"
      redirect_to :action => :admin
      return false
    end
  end
  
  def index
    @gates      = Gate.is_enabled
    @gate       = Gate.new
    @cars_count = CarPark.is_left.count
  end
  
  def exit
    @current_car           = CarPark.find(params[:id])
    if @current_car
      payment              = Payment.find(:last, :conditions => ["car_park_id = ? and is_paid = true", @current_car.id])
      @time_start          = Time.now
      @time_end            = payment.paid_at + MINUTES_TO_LEAVE_AFTER_PAYING.minutes
      
      if @time_start < @time_end
        @current_car.is_left          = true
        @current_car.is_late_to_pay   = false
        @current_car.left_at          = @time_start.strftime('%Y-%m-%d %H:%M:%S')
        if @current_car.save
          flash[:success]             = "You are left the Park House. You are always welcome here!"
          redirect_to :action => :goodbye
          return false
        end
      else
        @current_car.is_late_to_pay   = true
        payment.is_extra_money        = true
        if @current_car.save and payment.save
          flash[:error]               = "You are too slowly! 30 minutes for you is not enough to leave the parking? Oh!"
          redirect_to :controller => :car_parks, :action => :show, :id => @current_car.id
          return false
        end
      end
    end
  end
  
  def conditions
    @car_count = CarPark.find(:all).count
  end

end
