require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) {Tag.create(description: "Accessibility")}
  describe "Attributes" do
    it "is valid with a description" do
      expect(tag.valid?).to eq true
    end

    it "is invalid without a description" do
      tag.description = nil
      expect(tag.valid?).to eq false
    end
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:testimonials) }
  end
end
