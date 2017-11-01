require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'

class Property
  include DataMapper::Resource

  property :id,           Serial
  property :description,  String
  property :price,        Integer

  has n, :photos
  has n, :bookings
  belongs_to :user
end
