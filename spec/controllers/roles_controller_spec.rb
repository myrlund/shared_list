require File.dirname(__FILE__) + '/../spec_helper'

describe RolesController do
  fixtures :all
  render_views

  before(:each) do
    @valid_attributes = Role.first.attributes
    @invalid_attributes = Role.first.attributes
    @invalid_attributes[:title] = ""
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Role.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    post :create, :role => @invalid_attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    post :create, :role => @valid_attributes
    response.should redirect_to(role_url(assigns[:role]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Role.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    put :update, :id => Role.first, :role => @invalid_attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    put :update, :id => Role.first, :role => @valid_attributes
    response.should redirect_to(role_url(assigns[:role]))
  end

  it "destroy action should destroy model and redirect to index action" do
    role = Role.first
    delete :destroy, :id => role
    response.should redirect_to(roles_url)
    Role.exists?(role.id).should be_false
  end
end
