require "./lib/TwitterBot"

class FundTweetsController < ApplicationController

  # I'm not sure why this is even here since there's no point of routes / actions.
  # Doesn't my rake task and TwitterBot.rb do all of this now?
  def retweet
    TwitterBot.new.retweet
  end

end
