class JoinRequest
  include MongoMapper::EmbeddedDocument
  
  key :body, String, :required => true
  key :accepted, Boolean, :default => false
  key :created_at, Time, :default => Time.now.utc
    
  belongs_to :user
  belongs_to :event
end