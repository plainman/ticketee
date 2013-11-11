FactoryGirl.define do
  factory :user do
    name "MaxMustermann"
    email "email@world.com"
    password "abc123"
    password_confirmation "abc123"
  end
end