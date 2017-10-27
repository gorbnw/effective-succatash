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
