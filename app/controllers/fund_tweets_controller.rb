class FundTweetsController < ApplicationController

  def search
    @search_results = twitter_client.search("tech conference scholarship").take(5)
    render json: @search_results
  end

  def retweet
    search
    @search_results.each do |tweet|
      twitter_client.retweet(tweet)
    end
  end

  private

  # def prep_results(results)
  #   retweet_ids = []
  #
  #   @search_results.each do |tweet|
  #     retweet_ids << tweet.id
  #   end
  #   retweet_ids
  # end

end
