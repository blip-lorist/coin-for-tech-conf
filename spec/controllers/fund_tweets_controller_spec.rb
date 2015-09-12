require 'rails_helper'
require 'vcr_setup'

RSpec.describe FundTweetsController, type: :controller do

  describe "twitter_client" do

    it "successfully signs into the CoinForTechConf account" do
      VCR.use_cassette "twitter_creds" do
        bot = TwitterBot.new.twitter_client
        expect(bot.verify_credentials.id).to eq(3451101679)
      end
    end
  end

  describe "search" do

    it "collects a list of search results containing certain keywords" do
      VCR.use_cassette "search" do
        results = TwitterBot.new.search
        expect(results.first.text).to include("scholarship")
        expect(results.first.text).to include("tech" || "technology")
        expect(results.first.text).to include("conf" || "conference")
      end
    end
  end

  describe "filter results" do

    it "removes tweets with text that are more than 80% similar" do
      VCR.use_cassette "filtered results" do
        tweet_1 = Twitter::Tweet.new(id: 1, text: "Have you applied for the Unigoats Rule scholarship yet? Only three days left!")
        tweet_2 = Twitter::Tweet.new(id: 2, text: "Here take a 1% discount for the Lord Business Evil Tech Conference")
        tweet_3 = Twitter::Tweet.new(id: 3, text: "Want a 1% discount for the Lord Business Evil Tech Conference?")

        @search_results = [tweet_1, tweet_2, tweet_3]


        filtered_results = TwitterBot.new.filter(@search_results)
        expect(filtered_results.count).to eq(2)
      end
    end
  end

  describe "retweet" do
    context "with search results" do
      it "retweets stuff" do
        VCR.use_cassette "retweet stuff" do
          controller.send(:retweet)
          bot = TwitterBot.new
          search_results = bot.search
          filtered_results = bot.filter(search_results)
          tweet_id = filtered_results.first.id
          tweet = TwitterBot.new.twitter_client.status(tweet_id)

          expect(tweet.retweeted?).to eq(true)
        end
      end
    end
  end
end
