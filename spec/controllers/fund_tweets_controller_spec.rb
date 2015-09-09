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

    it "returns a tweet after a successful search query" do
      VCR.use_cassette "twitter_search_results" do
        get :search
        expect(assigns(:search_results).count).to eq(1)
      end
    end
  end

  describe "POST fund_tweets#retweet" do

    context "when a unique retweet is found" do
      it "retweets" do
        VCR.use_cassette "retweets" do
          post :retweet
        end
      end
    end

    context "when a duplicate is found" do
      it "skips the retweet attempt" do
      end
    end
  end
end
