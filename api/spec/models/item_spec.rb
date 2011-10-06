require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  it "should be valid with valid attributes" do
    item = FactoryGirl.build(:item)
    item.should be_valid
  end
  it "should be invalid with invalid attributes" do
    item = FactoryGirl.build(:item)
    item.title = ""
    item.should_not be_valid
  end
  
  it "should toggle done attribute with its done_at attribute" do
    item = FactoryGirl.build(:item)
    item.done_at = nil
    item.done?.should be_false
    item.done_at = DateTime.now
    item.done?.should be_true
  end
  
  it "should toggle done attribute with its done_at attribute" do
    item = FactoryGirl.build(:item)
    item.done = true
    item.done_at.should_not be_nil
    item.done = false
    item.done_at.should be_nil
  end
  
end
