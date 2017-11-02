class PropertySearcher
  attr_reader :location, :checkin, :checkout
  def initialize(args)
    @location = args[:location]
    @checkin = args[:checkin]
    @checkout = args[:checkout]
  end

  def search_location
    Property.all(:location => location) 
  end

  def search_available_properties
    throw Error("Dates have not been provided") unless !!checkin && !!checkout
    available_properties = []
    properties = Property.all
    properties.each do |property|
      booking = Booking.new(check_in: checkin, check_out: checkout, user_id: User.first.id, property_id: property.id)
      available_properties <<  property if booking.valid_booking?
    end
    available_properties
  end


end