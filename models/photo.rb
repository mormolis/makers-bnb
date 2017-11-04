require_relative "photo_uploader"

class Photo
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  belongs_to :property
  mount_uploader :source, PhotoUploader
end
