class Photo < Base
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document
  
  key :name, String
  
  belongs_to :album
  
  mount_uploader :image, ImageUploader
end
