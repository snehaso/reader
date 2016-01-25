FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@reader.me" }
    sequence(:username) { |n| "person#{n}" }
    password               "password"
    password_confirmation  "password"
  end
end
