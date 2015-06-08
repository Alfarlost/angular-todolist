FactoryGirl.define do
  factory :task do
    description { Faker::Lorem.sentence }
    sequence(:priority ) {|n| n}
    deadline nil
    completed false
  end
end
