ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'bcrypt'
require_relative 'data_mapper_setup.rb'
require_relative 'models/property.rb'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'secret phrase'

  get '/' do
    'hello'
  end

  get '/properties' do
    @properties = Property.all
    erb(:index)
  end

  get '/properties/new' do
    erb :'properties/new'
  end

  post '/properties' do
    p params
    p params[:description]
    Property.create(description: params[:description], price: params[:price])
    redirect '/properties'
  end

  run! if app_file == $PROGRAM_NAME
end
