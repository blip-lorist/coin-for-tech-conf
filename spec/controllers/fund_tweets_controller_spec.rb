require 'rails_helper'

RSpec.describe FundTweetsController, type: :controller do

  describe "GET fund_tweets#search" do
    let (:twitter_params) {{search_term: "tech conference scholarship"}}

    it "returns JSON" do
      get :search
      expect(response.header['Content-Type']).to include 'application/json'
    end

    it "returns tweets after a successful search query" do
      VCR.use_cassette 'twitter_search_results' do
        get :search
        expect(assigns(:results).count).to eq(1)
      end
    end
  end
end
