require "./lib/TwitterBot"

task :search_and_retweet do
  TwitterBot.new.retweet
end
