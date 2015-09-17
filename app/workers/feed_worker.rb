class FeedWorker
  include Sidekiq::Worker
  require 'feed_parser'

  def perform(url)
    FeedParser.parse(url)
  end 
end
