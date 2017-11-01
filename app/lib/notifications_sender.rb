require_relative './gmailer.rb'
class NotificationSender
  
  attr_reader :gmailer, :booking, :property, :landlord, :customer

  def initialize(gmailer = Gmailer.new, booking_id)
    @gmailer = gmailer
    @booking = Booking.get(booking_id)
    @property = Property.get(booking.property_id)
    @landlord = User.get(property.user_id)
    @customer = User.get(booking.user_id)
  end

  def login_to_gmail(username, password)
    gmailer.login(username, password)
  end

  def logout
    gmailer.logout
  end


  def send_to_customer
    email_body = "Thank you for your booking! 
                  Bellow there are some details 
                  of your booking\nCheck in date #{booking.check_in}\n
                  Check out date #{booking.check_out}\n\n
                  Property:#{property.description}\n
                  Enjoy your stay!"

    
    gmailer.send_email(recipient: customer.email,
                      email_subject: "Booking confirmation",
                      message: email_body )
  end

  def send_to_landlord
    email_body = "You have a new booking! 
    Bellow there are some details 
    of the booking\nCheck in date #{booking.check_in}\n
    Check out date #{booking.check_out}\n\n
    Property:#{property.id}\n
    Customer email: #{customer.email}
    Customer name: #{customer.first_name} #{customer.last_name}"
  
    gmailer.send_email(recipient: landlord.email,
    email_subject: "New Booking!",
    message: email_body )
  
  end
end


#Usage
# sender = new NotificationSender(43)
# sender.login_to_gmail(ENV['gmail_username'], ENV['gmail_password'])
# sender.send_to_customer
# sender.send_to_landlord
# sender.logout