class List < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :owner, :class_name => "User"
  has_many :items
  
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions, :source => :user
  
  validates_presence_of :title
  validates_presence_of :owner
end
