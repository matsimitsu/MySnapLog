# config/initializers/mongo_mapper.rb

# load YAML and connect
database_yaml = YAML::load(File.read(RAILS_ROOT + '/config/database.yml'))
if database_yaml[Rails.env] && database_yaml[Rails.env]['adapter'] == 'mongodb'
  mongo_database = database_yaml[Rails.env]
  MongoMapper.connection = Mongo::Connection.new(mongo_database['host'], 27017, :pool_size => 5, :timeout => 5)
  MongoMapper.database =  mongo_database['database']
  MongoMapper::Document::ClassMethods.send(:include, Scopify::ClassMethods)
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end