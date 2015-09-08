class FundTweetsController < ApplicationController

  def search
    @search_results = twitter_client.search("tech conference scholarship").take(5)
    render json: {}
  end

  def retweet
    @post = twitter_client.update("Look out, world!")
    render json: {}
  end
end
