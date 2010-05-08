class User < Base
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  key :username, String, :required => true
  key :slug, String
  slug_key :username, :unique => true
  
  many :albums
  def to_param
    slug# or whatever you set :url_attribute to
  end
  
end