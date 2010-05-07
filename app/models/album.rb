class Album < Base
  
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :slug, String
  
  many :photos
  belongs_to :user
  
  acts_as_url :name, :url_attribute => :slug
  
  def to_param
    slug# or whatever you set :url_attribute to
  end
end
