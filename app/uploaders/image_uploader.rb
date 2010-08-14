class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageScience
    
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" 
  end  
  
  def url(version=nil)
    "/files/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{version}_#{versions[version.to_sym].model.image_filename}" 
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
        
  version :small_thumb do
    process :resize_to_fill => [100,100]
  end
  
  version :large_thumb do
    process :resize_to_fill => [180,180]
  end
  
  version :small do
    process :resize_to_fit => [240,160]
  end
  
  version :medium do
    process :resize_to_fit => [595,595]
  end
  
  version :large do
    process :resize_to_fit => [900,900]
  end
  
  version :huge do
    process :resize_to_fit => [1280,720]
  end
end