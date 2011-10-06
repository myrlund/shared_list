class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :owned_lists, :class_name => "List", :foreign_key => "owner_id"
  has_many :subscriptions
  has_many :subscribed_lists, :through => :subscriptions, :source => :list
  
  def lists
    owned_lists + subscribed_lists
  end
  
  def to_s
    username
  end
  
end
