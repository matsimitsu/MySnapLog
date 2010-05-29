class User < Base
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  key :username, String, :required => true
  key :flickr_token, String
  key :slug, String
  slug_key :username
  
  validates_uniqueness_of :username
  
  many :activities, :dependent => :destroy
  many :events
  many :photos, :dependent => :destroy
  many :managed_events, :foreign_key => :manager_id, :class_name => 'Event', :dependent => :destroy
  def to_param
    slug# or whatever you set :url_attribute to
  end
  
  def set_flickr_token(token)
    update_attributes(:flickr_token => token)
  end
end