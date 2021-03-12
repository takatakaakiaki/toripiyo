FactoryBot.define do
  factory :tweet do
    image { Faker::Lorem.sentence }
    title { Faker::Lorem.sentence }
    article { Faker::Lorem.sentence }
    category_id { 4 }
    prefecture_id { 2 }
    city { '札幌市北区' }
    association :user

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('app/assets/images/inko-sample.png'), filename: 'inko-sample.png')
    end
  end
end
