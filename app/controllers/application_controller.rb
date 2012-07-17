class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  
  protect_from_forgery

protected
  def if_car?
    if !session[:car_in]
      redirect_to :controller => :welcome, :action => :index
      flash[:error] = 'You cannot be here without a car!'
      return false
    end
  end
end
