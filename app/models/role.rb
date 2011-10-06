class Role < ActiveRecord::Base
  attr_accessible :title
  
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_format_of :title, :with => /^[a-z]+$/
  
  has_many :subscriptions
  
  def to_s
    title
  end
  
  def to_param
    title.downcase
  end
  
  def self.default
    Role.find_or_create_by_title("read")
  end
  
end
