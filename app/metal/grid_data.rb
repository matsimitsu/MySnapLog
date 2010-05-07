# rails metal to be used with carrierwave (gridfs) and MongoMapper

require 'mongo'
require 'mongo/gridfs'

# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class GridData < Rails::Rack::Metal
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/gridfs\/(.+)$/
      key = $1
      if ::GridFS::GridStore.exist?(MongoMapper.database, key)
        ::GridFS::GridStore.open(MongoMapper.database, key, 'r') do |file|
          [200, {'Content-Type' => file.content_type}, [file.read]]
        end
        
      else
        [404, {'Content-Type' => 'text/plain'}, ['File not found.']]
      end
    else
      [404, {'Content-Type' => 'text/plain'}, ['File not found.']]
    end
  end
end
