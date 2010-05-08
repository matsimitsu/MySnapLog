class UsersController < ApplicationController
  
  before_filter :load_user
  
  def show
    redirect_to user_albums_path(@user)
  end
  
  def load_user
    @user ||= User.find_by_slug(params[:id])
  end
end
