require 'rails_helper'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do
    let (:twitter_params) {{search_term: "tech conference scholarship"}}

    it "receives search results from the Twitter API" do
      VCR.use_cassette 'twitter_search_results' do
        get :search, twitter_params
        expect(assigns(:results).count).to eq(3)
      end
    end
  end




end
