require 'carrierwave'
require 'carrierwave/datamapper'


class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    'public/properties'
  end
end


