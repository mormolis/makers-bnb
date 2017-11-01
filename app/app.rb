ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'bcrypt'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require_relative 'models/property.rb'
require_relative 'lib/notifications_sender.rb'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'secret phrase'
  
  def send_email_notifications(booking_id)
    begin
      sender = NotificationSender.new(booking_id)
      test = sender.login_to_gmail(ENV['gmail_username'], ENV['gmail_password'])
      sender.send_to_customer
      sender.send_to_landlord
      sender.logout
    rescue Exception => e 
      session[:error] = "succesfully booked but email notifications did not send"
      puts e.message
      puts e.backtrace.inspect
    end

  end

  get '/' do
    redirect '/properties'
  end

  get '/properties' do
    @properties = Property.all
    erb(:index)
  end

  get '/properties/new' do
    if current_user == nil
      redirect "/sessions/new"
    end
    erb :'properties/new'
  end

  post '/properties' do
    property = Property.create(description: params[:description], price: params[:price], user_id: session[:user_id])
    Photo.create(title: params[:imgdescription], source: params[:pic], property_id: property.id) # where is this coming from
    redirect '/properties'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create( email: params[:email], 
                        password: params[:password],
                        first_name: params[:first_name],
                        last_name: params[:last_name],
                        username: params[:username])
    session[:user_id] = user.id
    redirect '/properties'
  end

  helpers do
    def current_user
       @current_user ||= User.get(session[:user_id])
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.first(email: params[:email])
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect to '/properties'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/properties/book:name' do
    @user = session[:user_id]
    session[:property_id] = params[:name].delete(':').to_i
    @property = Property.get(session[:property_id])
    @bookings = @property.bookings
    erb(:'properties/booking')
  end

  get '/bookings' do
    @bookings = Booking.all
    erb :'bookings/bookings'
  end

  post '/bookings' do
    session[:errors] = nil
    booking = Booking.new(check_in: params[:check_in], check_out: params[:check_out], property_id: params[:property_id], user_id: params[:user_id])
    if booking.valid_booking?
      booking.save
      session[:error] = 'property successfuly booked!'
      #send email to users involved
      send_email_notifications(booking.id)

      redirect '/' if booking.saved?
    else
      session[:error] = "property not available for the selected dates"
      redirect "/properties/book:#{params[:property_id]}"
    end
  end

  run! if app_file == $PROGRAM_NAME
end
