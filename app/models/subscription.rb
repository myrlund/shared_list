class Subscription < ActiveRecord::Base
  belongs_to :list
  belongs_to :user
  
  belongs_to :role
  
  validates_presence_of :list, :user, :role
  
  after_initialize :assign_defaults
  
  def assign_defaults
    self.role ||= Role.default
  end
  
end
