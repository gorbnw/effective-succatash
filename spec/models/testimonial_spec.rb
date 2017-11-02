require 'rails_helper'

describe Testimonial, type: :model do
  let!(:testimonial){FactoryBot.create(:testimonial, :positive)}
  let!(:user){FactoryBot.create(:user)}
  let!(:tag1){FactoryBot.create(:tag, :tag1)}
  let!(:tag2){FactoryBot.create(:tag, :tag2)}
  let!(:vote1){Vote.create(user: user, testimonial: testimonial)}
  let!(:testimonial_sample) {Testimonial.new(
    description: "The bouncers are rad!",
    anonymous: false,
    positive: true
    )}

  describe 'associations' do
    it 'has many tags' do
      testimonial.tags << [tag1, tag2]
      testimonial.save!
      expect(testimonial.tags).to eq [tag1, tag2]
    end

    it {is_expected.to have_many(:votes)}

    it {is_expected.to belong_to(:user)}

  end

  describe "validations" do
    it 'is not valid without a discription' do
      testimonial_sample.description = ""
      expect(testimonial_sample).to_not be_valid
    end

    it 'is not valid without an anonymous tag boolean' do
      testimonial_sample.anonymous = nil
      expect(testimonial_sample).to_not be_valid
    end

    it 'is not valid without a positive tag boolean' do
      testimonial_sample.positive = nil
      expect(testimonial_sample).to_not be_valid
    end
  end
end
