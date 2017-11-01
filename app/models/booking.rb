require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :check_in, Date
  property :check_out, Date

  belongs_to :property

end
