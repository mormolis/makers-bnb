ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './data_mapper_setup.rb'
require 'bcrypt'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'secret phrase'

  get "/" do
    "hello"
  end


  run! if app_file == $0
end
