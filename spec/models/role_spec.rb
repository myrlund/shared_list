require File.dirname(__FILE__) + '/../spec_helper'

describe Role do
  it "should be valid" do
    Role.new(:title => "foobar").should be_valid
  end
end
