require 'rails_helper'
require 'vcr_setup'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do
    VCR.use_cassette "twitter_search_results" do

      it "returns JSON" do
        get :search
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it "returns tweets after a successful search query" do
        get :search
        expect(assigns(:response).count).to eq(1)
      end
    end
  end
end
