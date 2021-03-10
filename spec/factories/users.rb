FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { '111aaa' }
    password_confirmation { password }
    last_name { '佐藤' }
    first_name { '太郎' }
    last_name_kana { 'サトウ' }
    first_name_kana { 'タロウ' }
    birthday { Faker::Date.backward }
  end
end
