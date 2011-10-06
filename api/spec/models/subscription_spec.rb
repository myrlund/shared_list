require File.dirname(__FILE__) + '/../spec_helper'

describe Subscription do
  it "should default role to 'read'" do
    subscription = FactoryGirl.create(:subscription)
    subscription.role.title.should == "read"
  end
end
