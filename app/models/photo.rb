class Photo < Base
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::Document
  
  key :name, String
  key :likers,    Array
  key :likes,     Integer, :default => 0
  key :tags,      Array
  
  many :comments
  ensure_index 'photo.likers' 
  belongs_to :album
  many :views
  
  mount_uploader :image, ImageUploader
  
  def like(hash)
    collection.update({'_id' => id, 'likers' => {'$ne' => hash}}, 
      {'$inc' => {'likes' => 1}, '$push' => {'likers' => hash}})
  end
  
  def create_comment(comment)
    comments << comment
    save
  end
  
  def view_count
    View.collection.group(['version'], 
      { :photo_id => id }, 
      {'sum' => 0},
      "function(doc, prev) { prev.sum += doc.views}",
      true)
  end
  
  def view_count_for_version(version)
    view_count.select{|vc| vc['version'] == version.to_s }.first['sum'].to_i rescue 0
  end
  
  def delete_comment(comment_id)
    comments.delete_if { |c| c.id == id }
    save
  end
end
