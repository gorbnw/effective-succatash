require 'rails_helper'
require_relative '../support/api'

RSpec.describe Business, type: :model do

  before(:each) do
    allow(ENV).to receive(:[]).with("YELP_TOKEN").and_return("yelp")
    allow(ENV).to receive(:[]).with("YELP_TOKEN_SECRET").and_return("secrets")
  end

  describe "#search_businesses" do
    let(:resp_double) { double(parsed_response: search_response) }
    let(:args) { {"term" => "hungryhut", "location" => "glencoe, al"} }
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(resp_double)
    end

    it 'returns a list of Yelp businesses' do
      expect(Business.search_businesses(args)).to eq resp_double.parsed_response["businesses"]
    end
  end

  describe '#get_offset_businesses' do
    
  end


end
