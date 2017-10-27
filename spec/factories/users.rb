FactoryBot.define do
  factory :user do
    username 'user'
    email 'test@test.com'
    password 'password'
    encrypted_password 'password'
  end
end
