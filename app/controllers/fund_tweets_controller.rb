class FundTweetsController < ApplicationController

  def search
    ## Since this will be automated, I'm going to just snag a single result at
    ## a time in an attempt to focus on quality of the retweet vs quantity.
    @search_results = twitter_client.search("tech conference scholarship").take(1)
    render json: @search_results
  end

  def retweet
    ## Snag the search results
    search

    binding.pry
    ## Retweet
    @search_results.each do |tweet|
      unless tweet.retweeted?
        begin
           ## I really need to catch duplicates before this point
          twitter_client.retweet(tweet)
        rescue Twitter::Error
          # Try to retweet the next tweet if there's a Twitter gem error
          next
        end
      end
    end
  end

  private

  # def remove_duplicates(search_results)
  #   ## Snag my last five retweets tweets
  #   ## See if the IDs match the current search results
  #   ## Kick out duplicates
  # end
end
