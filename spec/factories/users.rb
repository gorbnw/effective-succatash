FactoryBot.define do
  factory :user do
    username 'user'
    sequence(:email) {|n| "test#{n}@example.com"}
    password 'password'
    encrypted_password 'password'
  end
end
