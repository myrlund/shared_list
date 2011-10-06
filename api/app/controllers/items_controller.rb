class ItemsController < ApplicationController
  authorize_resource
  
  before_filter :load_list
  
  def index
    @items = @list.items
    
    respond_to do |format|
      format.html
      format.json { render :json => @items }
    end
  end

  def show
    @item = Item.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def new
    @item = Item.new
    @item.list = @list
    
    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def create
    @item = Item.new(params[:item])
    @item.list = @list
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to list_item_url(@list, @item), :notice => "Successfully created item." }
        format.json { render :json => @item, :status => :created, :location => @item }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def set_status
    @item = Item.find(params[:id])
    value = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(params[:done])
    @item.done = value
    @item.save
    
    respond_to do |format|
      format.html { redirect_to list_item_url(@list, @item) }
      format.json { head :ok }
    end
  end

  def edit
    @item = Item.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def update
    @item = Item.find(params[:id])
    
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to [@list, @item], :notice  => "Successfully updated item." }
        format.json { head :ok }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    
    respond_to do |format|
      format.html { redirect_to @list, :notice => "Successfully destroyed item." }
      format.json { head :ok }
    end
  end
  
  private
  
    def load_list
      @list = List.find(params[:list_id])
    end
  
end
