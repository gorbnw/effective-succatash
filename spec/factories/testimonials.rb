FactoryBot.define do
  factory :testimonial do
    description "It was good"
    anonymous true
    yelp_id "test"
    user
    trait(:positive) {positive true}
    trait(:negative) {positive false}
    trait(:safeway) { yelp_id "safeway-marysville" }
  end
end
