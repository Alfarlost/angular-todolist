FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    provider "facebook"
    uid "1234"
  end
end
