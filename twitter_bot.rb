require "twitter"
require "pry"
require 'dotenv'
Dotenv.load

class TwitterBot

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end
  end

  def search
    # Snag three recent tweets within five search groups
    first_search = twitter_client.search("conference OR conf apply OR win tech OR technology scholarship").take(3)

    second_search = twitter_client.search("conference OR conf tech OR technology free OR reduced ticket OR admission").take(3)

    third_search = twitter_client.search("underrepresented OR minority tech OR technology summit OR scholarship").take(3)

    fourth_search = twitter_client.search("scholarship apply ruby OR python OR javascript OR java OR php -clifton -monty").take(3)
    
    fifth_search = twitter_client.search("scholarship apply asp.net OR angularjs OR rails OR django OR meteor OR laravel OR codeigniter OR reactjs OR nodejs").take(3)

    @search_results = first_search + second_search + third_search + fourth_search + fifth_search
  end
  
  def retweet
    search
    @search_results.each do |tweet|
        begin
            twitter_client.retweet(tweet)
        rescue Twitter::Error # Lazy guard clause
            # Try to retweet the next tweet if there's a Twitter gem error
            next
        end
    end
    print "Retweeting complete."
  end

end

TwitterBot.new.retweet
