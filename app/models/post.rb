class Post < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attached_file :image,
                      :styles => {
                        :post         => "990x800>",
                        :small_thumb  => "75x75>",
                        :thumb        => "100x100>",
                        :small        => "240x240>",
                        :medium       => "595x500>",
                        :large        => "1024x1024>"
                      }
end