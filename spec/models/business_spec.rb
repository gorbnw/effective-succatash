require 'rails_helper'

RSpec.describe Business, type: :model do
  describe "Attributes" do
    let!(:business){FactoryBot.create(:business)}
    it 'has a name' do
      expect(business.name).to eq("Krumbo's Smell Zone")
    end
    it 'has a phone # ' do
      expect(business.phone).to eq("206-867-5309")
    end
    it 'has an address' do
      expect(business.address).to eq("99 Apricot Ct, Seattle, WA, 98144")
    end
  end

  xdescribe "#count_praise" do
    let!(:business){FactoryBot.create(:business)}
    let!(:testimonial){FactoryBot.create(:testimonial, :positive)}
    let!(:testimonial2){FactoryBot.create(:testimonial, :negative)}

      it 'counts positive praise for a given business' do
        business.testimonials << [testimonial, testimonial2]
        business.save!
        expect(business.count_praise).to eq "1 user gave praise!"
      end

      it 'counts negative praise for a given business' do
        business.testimonials << [testimonial, testimonial2]
        business.save!
        expect(business.count_criticism).to eq "1 user left criticism"
      end

      it 'returns "No praise for this business yet" when no positive praise exists' do
        expect(business.count_praise).to eq "No praise for this business yet"
      end

      it 'returns "No citicism for this business yet" when no negative praise exists' do
        expect(business.count_criticism).to eq "No criticism for this business yet"
      end
    end

    describe "validations" do
      let!(:business){FactoryBot.create(:business)}
      it "is valid with a name" do
        expect(business.valid?).to eq true
      end

      it "is invalid without a name" do
        business.name = nil
        expect(business.valid?).to eq false
      end

      it "is valid with a phone" do
        expect(business.valid?).to eq true
      end

      it "is invalid without a phone" do
        business.phone = nil
        expect(business.valid?).to eq false
      end

      it "is valid with a address" do
        expect(business.valid?).to eq true
      end

      it "is invalid without a address" do
        business.address = nil
        expect(business.valid?).to eq false
      end
    end
end
