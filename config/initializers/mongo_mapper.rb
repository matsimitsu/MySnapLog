# config/initializers/mongo_mapper.rb

# load YAML and connect
database_yaml = YAML::load(File.read(RAILS_ROOT + '/config/database.yml'))
if database_yaml[Rails.env] && database_yaml[Rails.env]['adapter'] == 'mongodb'
  mongo_database = database_yaml[Rails.env]
  MongoMapper.connection = Mongo::Connection.new( mongo_database['host'])
  MongoMapper.database =  mongo_database['database']
end