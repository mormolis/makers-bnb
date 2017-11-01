require "carrierwave"
require "carrierwave/datamapper"

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "photos/#{model.id}/"
  end
end
