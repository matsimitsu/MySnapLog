class Event < Base
  
  include MongoMapper::Document
  include MongoMapperExt::Slugizer
  
  key :name,            String, :required => true
  key :slug,            String, :index => true 
  key :public,          Boolean
  key :photos_per_page, Integer
  key :manager_id,      ObjectId
  key :user_ids,        Array, :index => true 
  
  
  # indexes
  ensure_index 'event.slug' 
  
  slug_key :name, :unique => true
  timestamps!
  
  many :users, :in => :user_ids 
  many :activities, :dependent => :destroy
  many :photos, :dependent => :destroy
  many :join_requests, :dependent => :destroy
  
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
  
  def add_user(user)
    self.add_to_set(:user_ids => user.id) 
    Activity.create(:event_id => id, :user_id => user.id, :date => Date.today.midnight, :action => 'joined_event')
  end
  
  def to_param
    slug# or whatever you set :url_attribute to
  end
  
  def create_join_request(join_request)
    join_requests << join_request
    save
  end
  
  def delete_join_request(join_request_id)
    join_requests.delete_if { |c| c.id == join_request_id }
    save
  end
  
end
