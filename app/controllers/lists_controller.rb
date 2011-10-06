class ListsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @lists = current_user.lists
    
    respond_to do |format|
      format.html
      format.json { render :json => @lists }
      format.xml  { render :xml => @lists }
    end
  end

  def show
    @list = List.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render :json => @list }
    end
  end

  def new
    @list = List.new
    
    respond_to do |format|
      format.html
      format.json { render :json => @list }
    end
  end

  def create
    @list = List.new(params[:list])
    
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, :notice => "Successfully created list." }
        format.json { render :json => @list, :status => :created, :location => @list }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @list = List.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render :json => @list }
    end
  end

  def update
    @list = List.find(params[:id])
    
    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to @list, :notice  => "Successfully updated list." }
        format.json { head :ok }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @list.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def add_subscriber
    @list = List.find(params[:id])
    @user = User.find(params[:user_id])
    
    @subscription = @list.subscriptions.create(:user => @user)
    
    respond_to do |format|
      if @subscription.valid?
        format.html { redirect_to @list, :notice => "Subscriber successfully added." }
        format.json { head :ok }
      else
        format.html { redirect_to @list, :error => "Subscriber could not be added." }
        format.json { render :json => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def remove_subscriber
    @list = List.find(params[:id])
    @user = User.find(params[:user_id])
    
    s = Subscription.find_by_list_id_and_user_id(@list.id, @user.id)
    s.destroy
    
    respond_to do |format|
      format.html { redirect_to @list, :notice => "Subscriber successfully removed." }
      format.json { head :ok }
    end
  end
  
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    
    respond_to do |format|
      format.html { redirect_to lists_url, :notice => "Successfully destroyed list." }
      format.json { head :ok }
    end
  end
end
