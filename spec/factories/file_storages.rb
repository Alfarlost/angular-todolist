FactoryGirl.define do
  factory :file_storage do
    file_name { Faker::Lorem.characters(10) }
  end

end
