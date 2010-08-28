class View < Base
  include MongoMapper::Document
  
  key :date,      Date
  key :time,      DateTime
  key :views,     Integer, :default => 0
  key :version,   String
  
  belongs_to :photo
end