
FactoryGirl.define do
  
  factory :user, :aliases => [:owner, :subscriber] do
    sequence(:username) { |n| "user#{n}" }
    password "passord"
    password_confirmation "passord"
    email { "#{username}@example.com" }
    admin false
    
    factory :admin do
      admin true
    end
  end
  
  factory :list do
    title "Testliste"
    description "Bare en beskrivelse."
    owner
  end
  
  factory :item do
    title "Random item"
    user
    list
  end
  
  factory :subscription do
    user
    list
  end
  
end
