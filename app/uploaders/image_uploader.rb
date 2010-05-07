class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
    
  storage :grid_fs
  
  def store_dir 
    "files/#{model.id}" 
  end 
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  version :thumb do
    process :resize_to_fill => [100,100]
  end
  
  version :small do
    process :resize_to_fit => [240,160]
  end
  
  version :medium do
    process :resize_to_fit => [595,400]
  end
  
  version :large do
    process :resize_to_fit => [900,650]
  end
  
  version :huge do
    process :resize_to_fit => [1280,720]
  end
end