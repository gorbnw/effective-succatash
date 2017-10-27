FactoryBot.define do
  factory :user do
    username user
    email 'test@test.com'
    encrypted_password 'password'
  end
end
