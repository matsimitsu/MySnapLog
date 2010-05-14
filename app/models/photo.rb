class Photo < Base
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document
  
  key :name,      String
  key :likers,    Array
  key :likes,     Integer, :default => 0
  key :tags,      Array
  timestamps!
  
  many :comments, :dependent => :destroy
  
  ensure_index 'photo.likers' 
  
  belongs_to :event
  belongs_to :user
  
  many :views, :dependent => :destroy
  
  scope :for_activity, lambda { |ids| { :order => 'created_at ASC', :limit => 5, :conditions => { :_id => ids } }}
  
  after_create :create_or_update_activity
  
  mount_uploader :image, ImageUploader
  
  def create_or_update_activity
    Activity.collection.update(
      { :event_id => event.id, :user_id => user.id, :date => Date.today.midnight, :action => 'uploaded_photos' },
      { '$inc' => {'count' => 1}, '$push' => {'photos' => id} },
      { :safe => true, :upsert => true }
    )
  end
  
  def like(hash)
    collection.update({'_id' => id, 'likers' => {'$ne' => hash}}, 
      {'$inc' => {'likes' => 1}, '$push' => {'likers' => hash}})
      
#    Activity.collection.update(
#      { :event_id => event.id, :date => Date.today.midnight, :action => 'liked_photo' },
#      { '$inc' => {'count' => 1}, '$push' => {'photos' => id} },
#      { :safe => true, :upsert => true }
#    )
  end
  
  def create_comment(comment)
    comments << comment
    save
  end
  
  def view_count(grouping)
    View.collection.group([grouping], 
      { :photo_id => id }, 
      {'sum' => 0},
      "function(doc, prev) { prev.sum += doc.views}",
      true)
  end
  
  def view_count_for_version(version)
    view_count('version').select{|vc| vc['version'] == version.to_s }.first['sum'].to_i rescue 0
  end
  
  def delete_comment(comment_id)
    comments.delete_if { |c| c.id == id }
    save
  end
end
