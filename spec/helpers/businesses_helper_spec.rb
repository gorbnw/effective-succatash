require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BusinessesHelper. For example:
#
# describe BusinessesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BusinessesHelper, type: :helper do
  describe "#tag_counts" do
    let(:testimonial1) { FactoryBot.create(:testimonial, :positive)}
    let(:testimonial2) { FactoryBot.create(:testimonial, :negative)}
    let(:tag1) { FactoryBot.create(:tag, :tag1) }
    let(:tag2) { FactoryBot.create(:tag, :tag2) }

    before(:each) do
      testimonial1.tags << tag1
      testimonial1.tags << tag2
      testimonial2.tags << tag1
      testimonial2.tags << tag2
    end

    it 'returns an array' do
      expect(tag_counts([testimonial1, testimonial2])).to be_an_instance_of(Array)
    end

    it 'returns an array of tag counts for each tag in the database' do
      expect(tag_counts([testimonial1, testimonial2])).to eq [["Tag", "Count"], ["super duper", 2], ["super pooper", 2]]
    end

    it 'returns zero counts when an empty array when the business does not have any testimonials' do
      expect(tag_counts([])).to eq [["Tag", "Count"], ["super duper", 0], ["super pooper", 0]]
    end

  end
end
