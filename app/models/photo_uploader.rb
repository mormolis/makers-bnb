require "carrierwave"

require "carrierwave/datamapper"

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # version :thumb do
  #   process :resize_to_fill => [300, 300]
  # end

  def store_dir
    "photos/#{model.id}/"
  end
end
