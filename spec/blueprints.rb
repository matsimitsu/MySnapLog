require 'machinist/mongo_mapper'
require 'sham'
require 'faker'

Event.blueprint do
  name            Faker::Name.name
  public          true
  photos_per_page 10
  manager_id      User.make.id
end

User.blueprint do
  email     Faker::Internet.email
  password 'secret'
  password_confirmation 'secret'
  username  Faker::Name.name
end

Photo.blueprint do
  filename      '/images/myimage.jpg'
  content_type  'image/jpg'
  event_id Event.make.id
  user_id User.make.id
end

Comment.blueprint do
  body  Faker::Lorem.paragraph
  email Faker::Internet.email
  name  Faker::Name.name
  site  'http://' + Faker::Internet.domain_name
end

Activity.blueprint do
  event_id Event.make.id
  user_id User.make.id
end

View.blueprint do
  photo_id Photo.make.id
  version 'medium'
end

JoinRequest.blueprint do
  body Faker::Lorem.paragraph
  accepted false
  user_id User.make.id
  event_id Event.make.id
end