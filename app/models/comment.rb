class Comment
  include MongoMapper::EmbeddedDocument
  
  key :body, String, :required => true
  key :email, String, :required => true
  key :name, String, :required => true
  key :site, String
  key :spam, Boolean, :default => false
  key :created_at, Time, :default => Time.now.utc
    
  belongs_to :photo
end