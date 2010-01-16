class User < ActiveRecord::Base
  acts_as_authentic
  has_many :memberships
  has_many :sites, :through => :memberships

  has_attached_file :avatar,
                      :styles => {
                        :thumb => "75x75>",
                        :small => "150x150>"
                      }
  
end