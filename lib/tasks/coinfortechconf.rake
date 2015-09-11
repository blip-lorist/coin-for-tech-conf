require "./lib/TwitterBot"

namespace :coinfortechconf do
  task search_and_retweet: :environment do
    TwitterBot.new.retweet
  end
end
