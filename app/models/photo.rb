require_relative "photo_uploader"

class Photo
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  
  mount_uploader :source, PhotoUploader
 
  belongs_to :property

end
