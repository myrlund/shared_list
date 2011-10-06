class Item < ActiveRecord::Base
  attr_accessible :title, :done_at
  
  belongs_to :list
  belongs_to :user
  
  validates_presence_of :title, :user, :list
  
  # Default to only unfinished items
  scope :pending, where("done_at IS NULL")
  scope :recently_done, lambda { where(["done_at >= ?", 5.days.ago]) }
  
  def self.relevant
    pending + recently_done
  end
  
  def done?
    not done_at.nil?
  end
  
  def done=(value)
    if value
      self.done_at = DateTime.now
    else
      self.done_at = nil
    end
  end
  
end
