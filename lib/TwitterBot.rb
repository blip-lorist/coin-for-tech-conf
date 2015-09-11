require "twitter"

class TwitterBot < ApplicationController
  def retweet
    # Snag the search results
    search
    # Retweet
    @search_results.each do |tweet|
      begin
        twitter_client.retweet(tweet)
      rescue Twitter::Error # Lazy guard clause
        # Try to retweet the next tweet if there's a Twitter gem error
        next
      end
    end
  end

  # def cron_test
  #   rando_string = (0...8).map { (65 + rand(26)).chr }.join
  #   @post = twitter_client.update(rando_string)
  # end

  private

  def search
    # Snag the five most recent relevant tweets
    @search_results = twitter_client.search("conference scholarship apply OR win tech OR technology -filter:retweets", result_type: "recent").take(5)
  end

end
