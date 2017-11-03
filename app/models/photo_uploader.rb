

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "lib/public/photos/#{model.id}/"
  end
end
