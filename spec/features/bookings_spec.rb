describe "Bookings" do
  before(:each) do
  @landlord = User.create(email: 'landlord@landlord.com',
                          password: 'secret1234',
                          username: 'landlord',
                          first_name: 'landlord',
                          last_name: 'landlord')

  @rentee = User.create(email: 'rentee@rentee.com',
                        password: 'secret1234',
                        username: 'rentee',
                        first_name: 'rentee',
                        last_name: 'rentee')

  @big_house = Property.create(description: 'Big house', price: 200, user_id: @landlord.id, location: "London")
  @small_house = Property.create(description: 'Small house', price: 100, user_id: @landlord.id, location: "Crete")

  @booking1 = Booking.create(check_in: "16/10/2030",
                              check_out: "17/10/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)   

@booking2 = Booking.create(check_in: "18/10/2030",
                            check_out: "19/10/2030",
                            user_id: @rentee.id,
                            property_id: @big_house.id)

  @booking3 = Booking.create(check_in: "30/10/2030",
                              check_out: "03/11/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)          
  
end

it "should store bookings to the databse" do
    expect(@booking1.saved?).to equal(true)
    expect(@booking2.saved?).to equal(true)
    expect(@booking3.saved?).to equal(true)
  end

describe "Booking Validation" do
  it "#valid_booking should return false case 1" do
    booking = Booking.new(check_in: "15/10/2030",
                              check_out: "4/11/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)
    expect(booking.valid_booking?).to equal(false)
  end

  it "#valid_booking should return true case 2" do
    booking = Booking.new(check_in: "20/10/2030",
                              check_out: "25/10/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)
    expect(booking.valid_booking?).to equal(true)
  end

  it "#valid_booking should return false case 3" do
    booking = Booking.new(check_in: "30/10/2030",
                              check_out: "03/11/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)
    expect(booking.valid_booking?).to equal(false)
  end

  it "#valid_booking should return false if check in date > check out date" do
    booking = Booking.new(check_in: "30/10/2030",
                              check_out: "03/11/2030",
                              user_id: @rentee.id,
                              property_id: @big_house.id)
    expect(booking.valid_booking?).to equal(false)
  end



end

end



