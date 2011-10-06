require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views
  
  def login(type)
    user = type.nil? ? nil : FactoryGirl.create(type)
    
    @controller.stubs(:current_user).returns(user)
  end
  
  before(:each) do
    @valid_attributes = FactoryGirl.attributes_for(:user)
    @invalid_attributes = FactoryGirl.attributes_for(:user)
    @invalid_attributes[:username] = ""
  end

  it "new action should render new template" do
    login(nil)
    
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    login(nil)
    
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    login(nil)
    
    post :create, :user => @valid_attributes
    response.should redirect_to(root_url)
  end

  it "edit action should redirect when not logged in" do
    login(nil)
    
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    login(:user)
    
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    login(nil)
    
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when user is invalid" do
    login(:user)
    
    put :update, :id => "ignored", :user => @invalid_attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when user is valid" do
    login(:user)
    
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end
end
