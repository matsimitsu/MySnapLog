# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'mongo_mapper', :version => '0.7.6'
  config.gem 'carrierwave', :version => '0.4.4'
  config.gem 'devise'
  config.gem 'will_paginate'
  config.gem 'haml'
  config.gem 'matsimitsu-risosu-san', :lib => 'risosu_san', :version => '~> 0.1.2', :source => 'http://gemcutter.org'
  config.gem 'mongomapper_ext'
  config.gem 'will_paginate'
  config.gem 'scopify'
  config.gem 'fleakr'
  config.gem 'navvy'
  
  config.time_zone = 'UTC'
  config.frameworks -= [ :active_record ]
end