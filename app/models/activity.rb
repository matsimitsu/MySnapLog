class Activity < Base
  include MongoMapper::Document
  
  include MongoMapper::Document
  key :source,    Hash
  key :action,    String
  key :count,     Integer, :default => 0
  key :date,      Time
  key :photos,    Array
  timestamps!
  belongs_to :user
  belongs_to :event
  
  scope :descending, :order => 'created_at DESC'
end