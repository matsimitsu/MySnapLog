class Album
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :slug, String
end
