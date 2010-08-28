class Photo < Base
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document
  
  key :name,      String
  key :likers,    Array
  key :likes,     Integer, :default => 0
  key :comments_count, Integer, :default => 0
  key :tags,      Array
  key :source,    String
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
    collection.update({'_id' => id}, 
      {'$inc' => {'comments_count' => 1}, '$push' => {'comments' => comment.as_json}})
      
    Activity.create(
      :event_id => event.id,
      :date => Date.today.midnight,
      :action => 'new_comment',
      :photos => [id],
      :count => 1,
      :source => comment.as_json,
      :private => true,
      :user => user
    )
  end
  
  def view_count(grouping)
    View.collection.group(grouping, 
      { :photo_id => id }, 
      {'sum' => 0},
      "function(doc, prev) { prev.sum += doc.views}",
      true)
  end
  
  def view_count_for_version_by_day(version, days=30)
    return_data = []
    data = View.collection.group(['version', 'date'], 
      { :photo_id => id, :date => { '$gt' => days.days.ago.midnight.utc } }, 
      {'sum' => 0},
      "function(doc, prev) { prev.sum += doc.views}",
      true).select{|vc| vc['version'] == version.to_s }
      puts data.inspect
      puts 1.days.ago.to_date.inspect
      (0..days).to_a.reverse.each do |i|
        return_data << { :date => i.days.ago.strftime("%d-%m-%Y"), :count => data.select { |d| d['date'].to_date == i.days.ago.to_date }.map{ |d| d['sum'].to_i }.first || 0 }
      end
      return_data
  end
  
  def latest_referers(limit=30)
    data = View.collection.group(['referer'], 
      { :photo_id => id, :date => { '$gt' => 30.days.ago.midnight.utc } }, 
      {'sum' => 0},
      "function(doc, prev) { prev.sum += doc.views}",
      true)
      data.sort_by{ |d| d['sum']}.reverse[0..limit]
  end
  
  
  def view_count_for_version(version)
    view_count(['version']).select{|vc| vc['version'] == version.to_s }.first['sum'].to_i rescue 0
  end
  
  def delete_comment(comment_id)
    comments.delete_if { |c| c.id == comment_id }
    save
  end
end
