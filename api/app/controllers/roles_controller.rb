class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find_by_title(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to @role, :notice => "Successfully created role."
    else
      render :action => 'new'
    end
  end

  def edit
    @role = Role.find_by_title(params[:id])
  end

  def update
    @role = Role.find_by_title(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to @role, :notice  => "Successfully updated role."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @role = Role.find_by_title(params[:id])
    @role.destroy
    redirect_to roles_url, :notice => "Successfully destroyed role."
  end
end
