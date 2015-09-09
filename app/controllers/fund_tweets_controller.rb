class FundTweetsController < ApplicationController

  def search
    @search_results = twitter_client.search("tech conference scholarship").take(5)
    render json: @search_results
  end

  def retweet
    search
    @search_results.each do |tweet|
      begin
         ## I really need to catch duplicates before this point 
        twitter_client.retweet(tweet)
      rescue Twitter::Error::Forbidden
        next # Try to retweet the next tweet if there's a duplicate
      end
    end
  end

  private

end
