# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  storage :file

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

end
