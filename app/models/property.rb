require 'data_mapper'
require 'dm-postgres-adapter'

class Property
  include DataMapper::Resource

  property :id,           Serial
  property :description,  String
  property :price,        Integer

  has n, :images
  belongs_to :user
end
