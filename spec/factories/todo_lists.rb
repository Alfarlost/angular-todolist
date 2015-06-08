FactoryGirl.define do
  factory :todo_list do
    title { Faker::Lorem.characters(10) }
    user_id 1
  end
end
