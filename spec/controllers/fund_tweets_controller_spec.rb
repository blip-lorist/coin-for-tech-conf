require 'rails_helper'
require 'vcr_setup'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do

    it "returns a tweet after a successful search query" do
      VCR.use_cassette "twitter_search_results" do
        controller.send(:search)
        expect(assigns(:search_results).count).to eq(1)
      end
    end
  end

  describe "POST fund_tweets#retweet" do
    it "returns a JSON object" do
      VCR.use_cassette "retweets" do
        get :retweet
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end

    context "when a unique tweet is found" do
      it "retweets it" do
        VCR.use_cassette "retweets" do
          post :retweet
          tweet_id = assigns(:search_results).first.id
          tweet = (controller.send(:twitter_client)).status(tweet_id)
          expect(tweet.retweeted?).to eq(true)
        end
      end
    end

    context "when a duplicate is found" do
      it "raises an error and skips it" do
        # Write this later
      end
    end
  end
end
