class CommentsController < ApplicationController
  
  before_filter :load_photo, :only => [:create]
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.valid?
      @photo.create_comment @comment
    end
  end
  
  private
  
  def load_photo
    @photo = Photo.find(params[:photo_id])
  end
  
end