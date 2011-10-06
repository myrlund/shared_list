require File.dirname(__FILE__) + '/../spec_helper'

describe List do
  it "should be valid with valid attributes" do
    list = FactoryGirl.build(:list)
    list.should be_valid
  end
  it "should be invalid with invalid attributes" do
    list = FactoryGirl.build(:list)
    list.title = ""
    list.should_not be_valid
  end
end
