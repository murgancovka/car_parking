module ApplicationHelper
  
  def time_length(seconds)
    days = (seconds / 1.day).floor
    seconds -= days.days
    hours = (seconds / 1.hour).floor
    seconds -= hours.hours
    minutes = (seconds / 1.minute).floor
    seconds -= minutes.minutes
    #{ days: days, hours: hours, minutes: minutes, seconds: seconds }
    #return "#{days} days | #{hours} hours | #{minutes} minutes"
    
    #return hour = (hours / 1)
    #return minute = minutes / 15.64
  end


end
