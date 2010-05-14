class Event < Base
  
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  key :name,            String, :required => true
  key :slug,            String
  key :public,          Boolean
  key :photos_per_page, Integer
  key :users,           Array
  key :manager_id,      ObjectId
  
  # indexes
  ensure_index 'event.slug' 
  
  slug_key :name, :unique => true
  timestamps!
  
  many :activities
  many :photos
  belongs_to :manager, :class_name => 'User'
    
  scope :recent, :order => 'created_at DESC'
  scope :limited, lambda { |limit| { :limit => limit }}
  
  
  after_create :create_activity
  
  def create_activity
    Activity.create(:event_id => id, :user_id => manager_id, :date => Date.today.midnight, :action => 'new_event')
  end
  
  def comments_count
    0
  end
  
  def to_param
    slug# or whatever you set :url_attribute to
  end
end
