class CarParksController < ApplicationController
  protect_from_forgery
  
  include ActionView::Helpers::NumberHelper
  
  layout 'application'
  
  def show
    current_car       = CarPark.exists?(params[:id])
    payment            = Payment.find(:first, :conditions => ["car_park_id = ? and is_paid = true", params[:id]])
    
    if current_car #and !payment.is_paid
      @current_car      = CarPark.find(params[:id])
      @time_end         = @current_car.created_at + FREE_MINUTES_ON_THE_PARK.minutes #15
      @time_ends_in_15  = @time_end.strftime('%H:%M')
      
      if payment
        @time_creation_of_ticket = payment.paid_at.strftime('%H:%M')
      else
        @time_creation_of_ticket = @current_car.created_at.strftime('%H:%M')
      end
        
    else
      flash[:error] = "We cannot find this car! Maybe car is left the building? ;-)"
      redirect_to :controller => :welcome, :action => :index
      return false
    end
  end
  
  def create
    @car_park_count = CarPark.is_left.count #CarPark.find(:all, :conditions => ["is_left = true"]).count
    if @car_park_count < NUMBERS_OF_CAR_ALLOWED_TO_PARKING
      
      #name of cars
      cars_name = Array.new
      cars_name = ['Opel', 'BMW', 'Mercedes', 'Honda', 'Toyota', 'Lada', 'Seat', 'Iveco', 'VW', 'Ferrari', 'Chevrolet', 'Dodge']
      car_park  = CarPark.new(params[:gate])
      
      car_park.name = cars_name.shuffle.first
      if car_park.save
        flash[:success] = "Congratulations! You are parked in safe zone now! You can go shopping! ; -)"
        redirect_to :action => :show, :id => car_park.id
        return false
      end
    else
      flash[:error] = "NO FREE SPACE AVAILABLE! (#{@car_park_count}/#{NUMBERS_OF_CAR_ALLOWED_TO_PARKING})!"
      redirect_to :controller => :welcome, :action => :index
      return false
    end
  end

  def payment
    @current_car     = CarPark.exists?(params[:id])
    payment_for_park = Payment.find(:first, :conditions => ["car_park_id = ? and is_paid = true", params[:id]])

      if @current_car
        @current_car  = CarPark.find(params[:id])
        @payment      = Payment.new
        
        #calculating time
        @time_start           = Time.now
        
        if payment_for_park
          @time_end           = @current_car.updated_at
          @ticket_created     = @current_car.updated_at.strftime("%H:%M:%S")
          @all_time           = (Time.now - @current_car.updated_at)
          @message            = "Additional <strong>0.5 &euro;</strong> you should pay. Your ticket once again was created at <u>#{@ticket_created}</u>. Don't be late at this time! ;- )".html_safe
          calculate_time      = (@time_start - @time_end)
          @payment_needed     = number_to_currency(((calculate_time / 3600) * PAYMENT_FOR_ONE_HOUR_IN_EURO + ADDITIONAL_PENALTY_IN_EURO), :unit => "", :separator => ".", :delimiter => "", :format => "%n %u")
        else
          @time_end           = @current_car.created_at + FREE_MINUTES_ON_THE_PARK.minutes
          @ticket_created     = @current_car.created_at.strftime("%H:%M:%S")
          @all_time           = (Time.now - @current_car.created_at)
          @message            = "Your ticket was created at #{@ticket_created}!"
          calculate_time      = (@time_start - @time_end)
          @payment_needed     = number_to_currency(((calculate_time / 3600) * PAYMENT_FOR_ONE_HOUR_IN_EURO), :unit => "", :separator => ".", :delimiter => "", :format => "%n %u")
        end
        
       
        @time_ends_in_15    = @time_end.strftime('%H:%M')
        @time_spent         = Time.at(calculate_time).utc.strftime("%H:%M:%S")
        @time_spent_all     = Time.at(@all_time).utc.strftime("%H:%M:%S")
        
        #request from post
        if request.post?
          payment           = Payment.new(params[:payment])
          if params[:commit] == "Click To Pay" 
            if @time_start > @time_end
              payment.is_paid   = true
              payment.how_much  = @payment_needed
              payment.paid_at   = Time.now.strftime('%Y-%m-%d %H:%M:%S')
            else
              payment.is_paid   = true
              payment.how_much  = 0
              payment.paid_at   = Time.now.strftime('%Y-%m-%d %H:%M:%S')
            end
            if payment.save
              flash[:success]   = "You have paid! You should leave park in less than 30 minutes, or you will pay extra money (15 minutes = 0.25 &euro;)".html_safe
            else
              flash[:error]      = "Error!"
            end
            redirect_to :controller => :car_parks, :action => :exit, :id => @current_car.id
            return false
          else
            redirect_to :controller => :car_parks, :action => :show, :id => @current_car.id
            return false
          end
        end
      end
    
  end
  
  def exit
    @car_park             = CarPark.new
    @current_car          = CarPark.find(params[:id])
  end
  
end
