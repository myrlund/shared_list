class UsersController < ApplicationController
  authorize_resource
  skip_authorization_check :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, :notice => "Thank you for signing up! You are now logged in." }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
