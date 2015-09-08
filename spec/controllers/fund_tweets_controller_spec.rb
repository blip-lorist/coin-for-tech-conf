require 'rails_helper'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do

    it "returns JSON" do
      VCR.use_cassette 'twitter_search_results' do
        get :search
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end

    it "returns tweets after a successful search query" do
      VCR.use_cassette 'twitter_search_results' do
        get :search
        expect(assigns(:response).count).to eq(1)
      end
    end
  end
end
