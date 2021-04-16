class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    if Rails.env.development?
      "uploads/#{model.id}"
    elsif Rails.env.test?
      "uploads/#{model.id}"
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
end
