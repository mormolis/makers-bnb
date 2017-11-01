ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'bcrypt'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require_relative 'models/property.rb'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'secret phrase'
  register Sinatra::Flash

  get '/' do
    redirect '/properties'
  end

  get '/properties' do
    @properties = Property.all
    erb(:index)
  end

  get '/properties/new' do
    p session[:user_id]
    p current_user
    if current_user == nil
      redirect "/sessions/new"
    end
    erb :'properties/new'
  end

  post '/properties' do
    p params[:pic]
    property = Property.create(description: params[:description], price: params[:price], user_id: session[:user_id])
    Image.create(description: params[:imgdescription], image: params[:pic], property_id: property.id)
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

  run! if app_file == $PROGRAM_NAME
end
