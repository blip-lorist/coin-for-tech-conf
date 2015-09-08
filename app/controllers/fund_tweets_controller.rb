class FundTweetsController < ApplicationController

  def search
    begin
      response = @twit_init.client.search("tech conference scholarship").take(1)
      status = :ok
    rescue
    end
    render json: {}
  end
end
