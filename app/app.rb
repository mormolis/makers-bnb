ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'bcrypt'
require_relative 'data_mapper_setup.rb'
require_relative 'models/property.rb'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'secret phrase'

  get '/' do
    redirect '/properties'
  end

  get '/properties' do
    @properties = Property.all
    erb(:index)
  end

  get '/properties/new' do
    erb :'properties/new'
  end

  post '/properties' do
    Property.create(description: params[:description], price: params[:price])
    redirect '/properties'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                       password: params[:password])
    session[:user_id] = user.id
    redirect '/properties'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $PROGRAM_NAME
end
