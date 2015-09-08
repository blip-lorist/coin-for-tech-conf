class FundTweetsController < ApplicationController

  def search
    response = @client.search("tech conference scholarship").take(1)
    render json: {}
  end
end
