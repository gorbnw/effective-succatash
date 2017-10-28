FactoryBot.define do
  factory :user do
    username 'user'
    email { Faker::Internet.email }
    password 'password'
    encrypted_password 'password'
  end
end
