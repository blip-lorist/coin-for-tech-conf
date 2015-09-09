require 'rails_helper'
require 'vcr_setup'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do

    it "returns JSON" do
      VCR.use_cassette "twitter_search_results" do
        get :search
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end

    it "returns five tweets after a successful search query" do
      VCR.use_cassette "twitter_search_results" do
        get :search
        expect(assigns(:search_results).count).to eq(5)
      end
    end
  end

  describe "POST fund_tweets#retweet" do

    it "collects all relevant tweet ids in @retweet_ids" do
      VCR.use_cassette "retweets" do
        post :retweet
        expect(assigns(:search_results).count).to be(5)
      end
    end
  end
end
