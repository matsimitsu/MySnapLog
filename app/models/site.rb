class Site < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :posts
  has_many :comments, :through => :posts
  has_one :owner, :class_name => 'User'
end
