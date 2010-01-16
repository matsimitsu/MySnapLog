class PostsController < ApplicationController
  
  def batch
  end
  
  def upload_image_block
    @post = Post.new(:image => swf_upload_data) # here you can use your favourite plugin to work with attachments
    @post.title = @post.image_file_name
    @post.save
    # use RJS here
    render :update do |page|
      page['blocks'].insert("<li>#{image_tag @post.image(:thumb) }")
    end
  end
  

end