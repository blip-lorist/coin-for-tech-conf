class FundTweetsController < ApplicationController

  def search
    @search_results = twitter_client.search("tech conference scholarship").take(5)
    render json: @search_results
  end

  def retweet
    search
    @search_results.each do |tweet|
      begin
        twitter_client.retweet(tweet)
      rescue
        next # Try to retweet the next tweet if there's a duplicate
      end
    end
  end

  private

end
