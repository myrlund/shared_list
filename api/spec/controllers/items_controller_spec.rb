require File.dirname(__FILE__) + '/../spec_helper'

describe ItemsController do
  fixtures :all
  render_views

  before(:each) do
    @list = FactoryGirl.create(:list)
    
    @valid_attributes = FactoryGirl.attributes_for(:item)
    @invalid_attributes = FactoryGirl.attributes_for(:item)
    @invalid_attributes[:title] = ""
  end

  it "set_status action should alter done_at property" do
    item = FactoryGirl.build(:item)
    item.done = false
    item.save
    
    put :set_status, :list_id => @list, :id => item, :done => true
    
    assigns[:item].done?.should be_true
  end

  it "index action should render index template" do
    get :index, :list_id => @list
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Item.first, :list_id => @list
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new, :list_id => @list
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    post :create, :list_id => @list, :item => @invalid_attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    post :create, :list_id => @list, :item => @valid_attributes
    # response.should redirect_to(list_item_url(@list, assigns[:item]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Item.first, :list_id => @list
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    put :update, :id => Item.first, :list_id => @list, :item => @invalid_attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    put :update, :id => Item.first, :list_id => @list, :item => @valid_attributes
    # response.should redirect_to(list_item_url(@list, assigns[:item]))
  end

  it "destroy action should destroy model and redirect to index action" do
    item = Item.first
    delete :destroy, :id => item, :list_id => @list
    response.should redirect_to(list_url(assigns[:list]))
    Item.exists?(item.id).should be_false
  end
end
