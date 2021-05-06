class ActivityImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::RMagick

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    if Rails.env.development?
      "activity/uploads/#{model.id}"
    elsif Rails.env.test?
      "activity/test/uploads/#{model.id}"
    else
      "#{model.id}"
    end
  end

  def extension_whitelist
    %w(png jpg)
  end

  def filename
    original_filename if original_filename
  end

  process :fix_rotate
  def fix_rotate
    manipulate! do |img|
      img = img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  process resize_to_limit: [800, 800]
  version :thumb do
    process resize_to_fill: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
