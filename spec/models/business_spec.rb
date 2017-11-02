require 'rails_helper'
require_relative '../support/api'

RSpec.describe Business, type: :model do

  before(:each) do
    allow(ENV).to receive(:[]).with("YELP_TOKEN").and_return("yelp")
    allow(ENV).to receive(:[]).with("YELP_TOKEN_SECRET").and_return("secrets")
  end

  describe "#search_businesses" do
    context 'when all valid fields are present' do
      let(:resp_double) { double(parsed_response: search_response) }
      let(:args) { {"term" => "hungryhut", "location" => "glencoe, al"} }
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(resp_double)
      end
      it 'returns a list of Yelp businesses' do
        expect(Business.search_businesses(args)).to eq resp_double.parsed_response["businesses"]
      end
    end
  end

  describe '#get_offset_businesses' do
    let(:resp_double) { double(parsed_response: offset_response) }
    let(:args) { {"term" => "beefjerky", "location" => "seattle"} }
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(resp_double)
    end
    it 'returns a list of offset Yelp businesses' do
      expect(Business.get_offset_businesses(args, 45)).to eq resp_double.parsed_response["businesses"]
    end
  end

  describe '#get_yelp_business_details' do
    let(:resp_double) { double(parsed_response: return_business) }
    let(:yelp_id) { "safeway-marysville" }
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(resp_double)
    end
    it 'returns a business' do
      expect(Business.get_yelp_business_details(yelp_id)).to eq resp_double.parsed_response
    end
  end


end
