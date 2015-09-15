class JobsWorker
  include Sidekiq::Worker
  include JobsHelper

  def perform
    parse_site
    parse_feed
  end 
end
