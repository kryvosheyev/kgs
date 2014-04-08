FactoryGirl.define do

  factory :post do
    title { Faker::Lorem.characters(rand(4..30)) }
    description { Faker::Lorem.characters(rand(6..30)) }

    factory :invalid_post do
      title nil
    end

  end

end