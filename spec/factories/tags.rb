FactoryBot.define do
  ## to create variables in your spec files, use the let statements below:
  ##  let!(:tag1){FactoryBot.create(:tag, :tag1)}
  ##  let!(:tag2){FactoryBot.create(:tag, :tag2)}

  factory :tag do
    trait(:tag1) {description "super duper"}
    trait(:tag2) {description "super pooper"}
  end
end
