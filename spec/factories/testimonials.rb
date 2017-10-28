FactoryBot.define do
  factory :testimonial do
    description "It was good"
    anonymous true
    business
    user
    trait(:positive) {positive true}
    trait(:negative) {positive false}
  end
end
