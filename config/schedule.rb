require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
set :path, Rails.root
set :output, Rails.root.join('log', 'cron.log')

every 10.minutes do
  runner SiteWorker.perform_async('https://careers-deltaed.icims.com/jobs/search?mobile=false&width=800&height=500&bga=true&needsRedirect=false&jan1offset=180&jun1offset=240')
  runner FeedWorker.perform_async('https://s3.amazonaws.com/masseria/peoplesoft/citizensbank.xml')
end
