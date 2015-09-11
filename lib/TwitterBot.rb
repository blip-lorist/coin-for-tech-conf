require "twitter"

unless Rails.env.production?
  require "dotenv-rails"
  require "pry-rails"
end

class TwitterBot

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end
  end

  def retweet
    unless search == nil
      post_stuff
    end
  end

  def post_stuff
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

  def search
    # Snag the five most recent relevant tweets
    first_search = twitter_client.search("conference OR conf apply OR win tech OR technology scholarship -filter:retweets -filter:mentions").take(10)
    second_search = twitter_client.search("conference OR conf tech OR technology free OR reduced ticket OR admission -filter:retweets -filter:mentions").take(10)
    third_search = twitter_client.search("from:diversity_conf scholarship").take(5)

    @search_results = first_search + second_search + third_search
  end

end
