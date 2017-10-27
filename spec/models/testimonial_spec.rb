require 'rails_helper'

describe Testimonial, type: :model do
  let(:testimonial_sample) {Testimonial.new(
    description: "The bouncers are rad!",
    anonymous: false,
    positive: true
  )}
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
