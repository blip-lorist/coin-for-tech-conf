class FundTweetsController < ApplicationController

  def search
    response = twitter_client.search("tech conference scholarship").take(1)
    render json: {}
  end
end
