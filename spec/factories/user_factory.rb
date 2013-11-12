FactoryGirl.define do
  factory :user do
    name "MaxMustermann"
    email "sample@example.com"
    password "abc123"
    password_confirmation "abc123"
    factory :admin_user do
      admin true
    end
  end
end