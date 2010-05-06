class Manage::AlbumsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @albums = current_user.albums
  end
  
  def upload_image_block
    @post = @current_site.posts.new(:user_id => @current_user, :image => swf_upload_data) # here you can use your favourite plugin to work with attachments
    @post.title = @post.image_file_name
    @post.save
    # use RJS here
    render :update do |page|
      page['blocks'].insert("<li>#{image_tag @post.image(:thumb) }")
    end
  end
  

end