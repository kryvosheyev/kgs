FactoryGirl.define do

  factory :friend do
    username { Faker::Lorem.characters(rand(4..30)) }
    association :user, factory: :user
  end
  
end