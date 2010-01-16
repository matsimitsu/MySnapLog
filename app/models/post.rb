class Post < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attached_file :image,
                      :styles => {
                        :post         => "990x800>",
                        :small_thumb  => "75x75>",
                        :thumb        => "100x100>",
                        :small        => "240x240>",
                        :medium       => "500x500>",
                        :large        => "1024x1024>"
                      }
end