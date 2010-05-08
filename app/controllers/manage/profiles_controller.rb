class Manage::ProfilesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to edit_manage_profile_path
    else
      render :action => :edit
    end
  end

end