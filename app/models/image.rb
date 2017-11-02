require_relative '../lib/image_uploader.rb'
class Image
  include DataMapper::Resource

  property :id, Serial
  property :description, Text

  mount_uploader :image, ImageUploader
end
