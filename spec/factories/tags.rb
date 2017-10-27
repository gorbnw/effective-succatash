FactoryBot.define do
  factory :tag do
    trait(:tag1) {description "super duper"}
    tag(:tag2) {description "super pooper"}
  end
end
