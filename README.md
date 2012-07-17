Car parking project is a emulation of car parking Hosue behaviour (WORK STATUS: Alpha). Cars are coming, cars are leaving this place.

First 15 minutes are free (like always), then you should pay for additional minute (15 minutes - 0.25 euro).

* Ruby On Rails 3

* MySQL

* Twitter Bootstrap


# Configurate

 Firstly install bundle
  
    bundle install
 
 To play with task manager just write 
 
    rake db:migrate
    
  This command will generates 3 tables

    
  Then just

    rails s
    
# MySQL Databse

  You can find the mysql scripts configuration in folder named 'mysql', there will be 3 files. Those files will contain 3 scripts to create tables with relattionships of course, and already with some data.

# Screenshots

* First page looks like 

![VZ](http://www.estof.net/2/index_.png)

You can see that Park House has a lot of free space

* Success! You are entered on the park house.

![VZ](http://www.estof.net/2/success.png)

* After clicking on `exit` your payment is created. If you was less than 15 minutes, you are free to go, if more, you should pay

![VZ](http://www.estof.net/2/payment_free.png)

* For example

![VZ](http://www.estof.net/2/payment.png)

* If you after payment somehow was on Park Hosue more than 30 minutes you will be punished

![VZ](http://www.estof.net/2/error_to_slowly.png)

* And need to pay additional 0.5 euro + additional minutes (Penalty)

![VZ](http://www.estof.net/2/error_penalty.png)

* After payment

![VZ](http://www.estof.net/2/success_paid.png)

* After leaving the Park House at last

![VZ](http://www.estof.net/2/success_left.png)

* There are free space

![VZ](http://www.estof.net/2/free_space8.png)

* Sorry no free space for you car

![VZ](http://www.estof.net/2/sorry_no_free_space.png)

* Some conditions and how many free spaces are available

![VZ](http://www.estof.net/2/free_spce_hopw_much.png)

* For Admin

![VZ](http://www.estof.net/2/admin_p.png)

# Constants

  There are some constants placed in `/config/constants.rb`
  
# MySQL query example

  Can be found in `mysql` folder
  

# Some bugs founded?

* EMAIL	    :   hello@estof.net
        
* URL	    :   www.estof.net


Current version is 0.0.1.
Copyright (c) 2012 Vitali Zakharoff.


