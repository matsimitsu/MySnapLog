# rails metal to be used with carrierwave (gridfs) and MongoMapper

require 'rubygems'
require 'mongo'

# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class GridData < Rails::Rack::Metal
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/files\/photo\/image\/(.+)$/
      key = $1
      match = key.match(/^(.+)\/([a-z]+)/).to_a
      id = match[1]
      version = match[2]
      begin
        MongoMapper.database.collection(:views).update({:version => version, :photo_id => BSON::ObjectID.from_string(id), :time => Time.now.floor(1.hour) }, {:$inc => {:views => 1}}, :upsert => true)
        File.open(Rails.root.join('public', 'uploads', 'photo', 'image', key), 'r') do |file|
          [200, {"Expires" => Time.now.advance(:days => 1).httpdate, 'Cache-Control' => 'max-age=31536000' }, [file.read]]
        end
      rescue 
        [404, {'Content-Type' => 'text/plain'}, ['File not found.']]
      end
    else
      [404, {'Content-Type' => 'text/plain'}, ['File not found.']]
    end
  end
end