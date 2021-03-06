require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'
require 'bcrypt'

class User
  attr_reader :password

  include DataMapper::Resource

  property :id, Serial
  property :username, String, required: true, unique: true
  property :first_name, String, required: true
  property :last_name, String, required: true
  property :email, String, format: :email_address, required: true, unique: true
  property :password_digest, Text

  has n, :propertys
  has n, :bookings

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      # return this user
      user
    end
  end
end

