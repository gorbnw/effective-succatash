FactoryBot.define do
  factory :testimonial do
    description "It was good"
    anonymous true
    positive true
    business
    user
  end
end
