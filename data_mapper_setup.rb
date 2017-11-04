require "sinatra"

require "rubygems"
require "bundler/setup"

Bundler.require(:default, Sinatra::Application.environment)

CarrierWave.configure do |config|
  config.permissions           = 0666  # Make uploads world-readable + writable
  config.directory_permissions = 0777  # Make directories world-read + write
  config.storage               = :file # Use file-based uploads

  # Use "tmp" directory to process uploads (e.g., resize)

  config.cache_dir = "#{Sinatra::Application.root}/tmp"
end

if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end


database_prefix = 'makers_bnb_'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/#{database_prefix}#{ENV['RACK_ENV']}")


require_relative './models/property.rb'
require_relative './models/user.rb'
require_relative './models/photo_uploader.rb'
require_relative './models/photo.rb'
require_relative './models/booking.rb'

DataMapper.finalize
DataMapper.auto_upgrade!
