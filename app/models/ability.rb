class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      if user.admin?
        can :manage, :all
      else
        can :manage, List, :owner_id => user.id
        
        can :read, List do |list|
          subscribes?(user, list)
        end
        can :update, List do |list|
          subscribes?(user, list) && subscription(user, list).role.title == "write"
        end
        can :manage, List do |list|
          subscribes?(user, list) && subscription(user, list).role.title == "manage"
        end
        
        can :manage, Item, :list => { :owner_id => user.id }
        can :read, Item do |item|
          subscribes?(user, item.list)
        end
        can :update, Item do |item|
          subscribes?(user, item.list) && subscription(user, item.list).role.title == "write"
        end
        can :manage, Item do |item|
          subscribes?(user, item.list) && subscription(user, item.list).role.title == "manage"
        end
      end
    end
  end
  
  def subscribes?(user, list)
    not subscription(user, list).nil?
  end
  
  def subscription(user, list)
    list.subscriptions.where(:user_id => user.id).first if list
  end
  
end
