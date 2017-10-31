require 'data_mapper'
require 'dm-postgres-adapter'
require_relative './models/property'
require_relative './models/user.rb'
require_relative './models/image.rb'
# require_relative './models/reply.rb'

database_prefix = 'makers_bnb_'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/#{database_prefix}#{ENV['RACK_ENV']}")

DataMapper.finalize
DataMapper.auto_upgrade!
