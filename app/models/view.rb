class View < Base
  include MongoMapper::Document
  
  key :time,      String
  key :views,     Integer, :default => 0
  key :version,   String
  
  belongs_to :photo
end