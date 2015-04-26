class FileUploader < CarrierWave::Uploader::Base

   include MiniMagick
  #include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end
end