require 'rails_helper'

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
  describe "top testimonial" do
    let(:user) { FactoryBot.create(:user)}

    context "when a business has one positive testimonial and one negative testimonial with votes" do
      let!(:positive){FactoryBot.create(:testimonial, :positive)}
      let!(:negative){FactoryBot.create(:testimonial, :negative)}
      let!(:vote_positive){Vote.create!(user: user, testimonial: positive)}
      let!(:vote_negative){Vote.create!(user: user, testimonial: negative)}

      it 'returns a testimonial' do
         expect(top_testimonial(Testimonial.where(yelp_id: "test"), true)).to be_an_instance_of(Testimonial)
      end
      it 'returns a positive testimonial'do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true).positive).to be(true)
      end
      it 'returns the first testimonial with the most votes' do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true)).to eq(positive)
      end

      it 'returns a negative testimonial'do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), false).positive).to be(false)
      end
      it 'returns the first testimonial with the most votes' do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), false)).to eq(negative)
      end
    end

    context "when a business has testimonials with no votes" do
      it 'when false is passed it returns nil' do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), false)).to be nil
      end
      it 'when true is passed in, it returns nil' do
        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true)).to be nil
      end
    end

    context "when a business has multiple positive and negative testimonials with multiple votes" do

      let!(:positive){FactoryBot.create(:testimonial, :positive)}
      let!(:positive2){FactoryBot.create(:testimonial, :positive)}
      let!(:negative){FactoryBot.create(:testimonial, :negative)}
      let!(:negative2){FactoryBot.create(:testimonial, :negative)}
      let!(:vote_positive1){Vote.create!(user: user, testimonial: positive)}
      let!(:vote_positive2){Vote.create!(user: user, testimonial: positive)}
      let!(:vote_positive3){Vote.create!(user: user, testimonial: positive)}

      let!(:vote_negative1){Vote.create!(user: user, testimonial: negative)}
      let!(:vote_negative2){Vote.create!(user: user, testimonial: negative)}
      let!(:vote_negative3){Vote.create!(user: user, testimonial: negative)}



      it 'returns a testimonial' do
        positive.yelp_id = "other_test"
        positive.save
        negative.yelp_id = "other_test"
        negative.save

        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true)).to be_an_instance_of(Testimonial)
      end
      it 'returns a positive testimonial'do
        positive.yelp_id = "other_test"
        positive.save
        negative.yelp_id = "other_test"
        negative.save

        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true).positive).to be(true)
      end

      it 'returns the first testimonial with the most votes' do
        positive.yelp_id = "other_test"
        positive.save
        negative.yelp_id = "other_test"
        negative.save

        expect(top_testimonial(Testimonial.where(yelp_id: "test"), true)).to eq(positive2)
      end

      it 'returns a negative testimonial'do
        positive.yelp_id = "other_test"
        positive.save
        negative.yelp_id = "other_test"
        negative.save

        expect(top_testimonial(Testimonial.where(yelp_id: "test"), false).positive).to be(false)
      end

      it 'returns the first testimonial with the most votes' do
        positive.yelp_id = "other_test"
        positive.save
        negative.yelp_id = "other_test"
        negative.save

        expect(top_testimonial(Testimonial.where(yelp_id: "test"), false)).to eq(negative2)
      end
    end

  end
end
