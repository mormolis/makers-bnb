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
    
    booking = Booking.new(check_in: checkin, check_out: checkout, user_id)

  end


end