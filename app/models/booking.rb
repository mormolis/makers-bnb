require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :check_in, Date
  property :check_out, Date
  property :user_id, String

  belongs_to :property

  #maybe refactor some day :P
  def valid_booking? 
    return false if self.check_in > self.check_out
    property = Property.get(self.property_id)
    valid = true
    property.bookings.each do |booking|
      if self.check_in >= booking.check_out
        next
      else
        unless self.check_out <= booking.check_in 
          valid = false
          break
        end
      end
    end
    valid
  end
end
