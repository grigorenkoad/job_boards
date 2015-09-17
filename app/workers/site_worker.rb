class SiteWorker
  include Sidekiq::Worker
  def perform(url)
    SiteParser.parse(url)
  end 
end
