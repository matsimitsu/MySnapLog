class Album < Base
  
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  key :name, String, :required => true
  key :slug, String
  key :public, Boolean
  key :photos_per_page, Integer
  slug_key :name, :unique => true
  timestamps!
  
  many :photos
  belongs_to :user
  
  def comments_count
    0
  end
  
  def to_param
    slug# or whatever you set :url_attribute to
  end
end
