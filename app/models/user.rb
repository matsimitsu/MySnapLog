class User < Base
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  key :username, String, :required => true
  key :slug, String
  slug_key :username
  
  validates_uniqueness_of :username
  
  many :activities
  many :events
  many :managed_events, :foreign_key => :manager_id, :class_name => 'Event'
  def to_param
    slug# or whatever you set :url_attribute to
  end
  
end