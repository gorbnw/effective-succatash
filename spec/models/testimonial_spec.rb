require 'rails_helper'

describe Testimonial, type: :model do
  let!(:testimonial_sample) {Testimonial.new(
    description: "The bouncers are rad!",
    anonymous: false,
    positive: true
    )}

  describe 'associations' do
    let!(:testimonial){FactoryBot.create(:testimonial, :positive)}
    let!(:user){FactoryBot.create(:user)}
    let!(:tag1){FactoryBot.create(:tag, :tag1)}
    let!(:tag2){FactoryBot.create(:tag, :tag2)}
    let!(:vote1){Vote.create(user: user, testimonial: testimonial)}
    it 'has many tags' do
      testimonial.tags << [tag1, tag2]
      testimonial.save!
      expect(testimonial.tags).to eq [tag1, tag2]
    end

    it {is_expected.to have_many(:votes)}

    it {is_expected.to belong_to(:user)}
  end

  describe "validations" do
    let!(:testimonial){FactoryBot.create(:testimonial, :positive)}
    let!(:user){FactoryBot.create(:user)}
    let!(:tag1){FactoryBot.create(:tag, :tag1)}
    let!(:tag2){FactoryBot.create(:tag, :tag2)}
    let!(:vote1){Vote.create(user: user, testimonial: testimonial)}

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

  describe "methods" do
    describe "#count" do
      context "when verbose => true is passed as an argument" do
        context "when positive => true is passed as an argument" do
          it "returns 'no praise for this business yet' if there are no positive testimonials" do
            expect(Testimonial.count({yelp_id: "test", positive: true, verbose: true})).to eq "No praise for this business yet"
          end

          context "when 1 positive testimonial exists" do
            let!(:testimonial){FactoryBot.create(:testimonial, :positive)}
            it "returns the number of positive testimonials for a certain business" do
              expect(Testimonial.count({yelp_id: "test", positive: true, verbose: true})).to eq "1 user gave praise!"
            end
          end

          context "when 2 or more positive testimonials exists" do
            let!(:testimonial2){FactoryBot.create(:testimonial, :positive)}
            let!(:testimonial3){FactoryBot.create(:testimonial, :positive)}
            it "returns the number of positive testimonials for a certain business" do
              expect(Testimonial.count({yelp_id: "test", positive: true, verbose: true})).to eq "2 users gave praise!"
            end
          end
        end

        context "when positive => false is passed as an argument" do
          it "returns 'no criticism for this business yet' if there are no positive testimonials" do
            expect(Testimonial.count({yelp_id: "test", positive: false, verbose: true})).to eq "No criticism for this business yet"
          end

          context "when 1 positive testimonial exists" do
            let!(:testimonial){FactoryBot.create(:testimonial, :negative)}
            it "returns the number of positive testimonials for a certain business" do
              expect(Testimonial.count({yelp_id: "test", positive: false, verbose: true})).to eq "1 user left criticism"
            end
          end

          context "when 2 or more positive testimonials exists" do
            let!(:testimonial2){FactoryBot.create(:testimonial, :negative)}
            let!(:testimonial3){FactoryBot.create(:testimonial, :negative)}
            it "returns the number of positive testimonials for a certain business" do
              expect(Testimonial.count({yelp_id: "test", positive: false, verbose: true})).to eq "2 users left criticism"
            end
          end
        end
      end

      context "when verbose => false is passed as an argument" do
        context "when positive => true is passed as an argument" do
          let!(:testimonial1){FactoryBot.create(:testimonial, :positive)}
          let!(:testimonial2){FactoryBot.create(:testimonial, :positive)}
          it "returns the number of positive testimonials for a certain business" do
            expect(Testimonial.count({yelp_id: "test", positive: true, verbose: false})).to eq 2
          end
        end

        context "when positive => false is passed as an argument" do
          let!(:testimonial1){FactoryBot.create(:testimonial, :negative)}
          let!(:testimonial2){FactoryBot.create(:testimonial, :negative)}
          it "returns the number of negative testimonials for a certain business" do
            expect(Testimonial.count({yelp_id: "test", positive: false, verbose: false})).to eq 2
          end
        end
      end
    end
    describe "#get_percent_pos" do
      context "when there are not positive testimonials" do
        it "returns 50 when total number of positive testimonials is less than 0" do
          expect(Testimonial.get_percent_pos("test")).to eq 50
        end
      end

      context "when there are positive testimonials" do
        let!(:testimonial1){FactoryBot.create(:testimonial, :positive)}
        let!(:testimonial2){FactoryBot.create(:testimonial, :positive)}
        it "returns the percentage of positive testimonials" do
          expect(Testimonial.get_percent_pos("test")).to eq 100
        end
      end
    end
  end
end
