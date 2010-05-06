# config/initializers/devise.rb

Devise.setup do |config|
  config.orm = :mongo_mapper
end