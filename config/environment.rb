# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'postmark-rails'
  config.action_mailer.postmark_api_key = "52329963-4c4d-4ebc-ad88-63b45aa2a063"
  
  config.time_zone = 'UTC'
  config.frameworks -= [ :active_record ]
end