require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :check_in, Date
  property :check_out, Date

  belongs_to :property

  # def <=>(other)
  #   return 1 if date_time < other.date_time
  #   return 0 if date_time == other.date_time
  #   -1
  # end
end
