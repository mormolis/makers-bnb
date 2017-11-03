class PropertySearcher
  attr_reader :location, :checkin, :checkout
  def initialize(args)
    @location = args[:location]
    @checkin = args[:checkin]
    @checkout = args[:checkout]
  end

  def search_available_properties
    return Property.all if all_fields_empty?
    return [] if check_in_check_out_empty? && search_location.empty?
    return search_location if check_in_check_out_empty? && !search_location.empty?
    
    properties = search_location
    available_properties = []
    properties.each do |property|
      booking = Booking.new(check_in: checkin, check_out: checkout, user_id: User.first.id, property_id: property.id)
      available_properties <<  property if booking.valid_booking?
    end
    available_properties
  end

  #needs refactoring
  def display_message
      if location.empty?
        if checkin.empty? || checkout.empty?
          message = "No properties found"
        else 
          message = "Displaying all properties for the dates: #{checkin} - #{checkout}"
        end
      else
  
        if !checkin.empty? && !checkout.empty?
          message = "Displaying results for #{location} dates: #{checkin} - #{checkout}"
        else
          message = "Displaying results for #{location}"
        end
      end
      message
    end
  
  
  private
  def search_location
    Property.all(:location => location)
  end

  def check_in_check_out_empty?
    checkin.empty? || checkout.empty?
  end

  def all_fields_empty?
    location.empty? && checkin.empty? && checkout.empty?
  end


end