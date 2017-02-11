class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
  end

  version :thumb do
    process resize_to_fill: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.title}-#{Time.now.getutc.to_s}"
  end
end
