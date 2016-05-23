require "twitter"
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
      # Snag five most recent tweets within three search groups
      first_search = twitter_client.search("conference OR conf apply OR win tech OR technology scholarship -didn -not").take(3)
  
      second_search = twitter_client.search("conference OR conf tech OR technology free OR reduced ticket OR admission -didn -not").take(3)
  
      third_search = twitter_client.search("underrepresented OR minority tech OR technology summit OR scholarship -didn -not").take(3)
  
      fourth_search = twitter_client.search("rubyconf OR pycon OR jsconf OR javaconf scholarship OR assistance apply OR win -didn -not", result_type: "recent").take(3)
  
      fifth_search = twitter_client.search("strangeloop OR railsconf OR smashingconf OR djangocon OR emberconf OR ngconf OR reactconf OR laracon scholarship OR assistance apply OR win -didn -not", result_type: "recent").take(3)
  
      sixth_search = twitter_client.search("gracehopper OR lesbianswhotech OR sxsw OR wwdc OR e3 scholarship OR assistance apply OR win -didn -not", result_type: "recent").take(3)
  
      @search_results = first_search + second_search + third_search + fourth_search + fifth_search + sixth_search
  
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

