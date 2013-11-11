FactoryGirl.define do
  factory :user do
    name "MaxMustermann"
    password "abc123"
    password_confirmation "abc123"
  end
end