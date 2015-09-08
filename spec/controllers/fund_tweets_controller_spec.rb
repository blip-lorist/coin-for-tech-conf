require 'rails_helper'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do
    let (:twitter_params) {{search_term: "tech conference scholarship"}}

    it "returns JSON" do
      get :search, twitter_params
      expect(response.header['Content-Type']).to include 'application/json'
    end


    # it "receives search results from the Twitter API" do
    #   VCR.use_cassette 'twitter_search_results' do
    #     get :search, twitter_params
    #
    #   end
    # end
  end
end
