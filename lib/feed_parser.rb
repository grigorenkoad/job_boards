require 'parser'
require 'open-uri'
require 'nokogiri'

class FeedParser < Parser
  def self.parse(url)
    page = Nokogiri::XML(open(url)) 
    page.css('job').each do |item|
      job = Job.new
      job[:title] = item.at_css('title').text
      job[:location] = item.at_css('country').text + ' / ' + item.at_css('state').text  + ' / ' + item.at_css('city').text
      job[:company] = item.at_css('company').text
      job[:category] = item.at_css('category').text
      job[:url] = item.at_css('url').text
      job[:req_num] = item.at_css('req_number').text
      job[:posted_at] = item.at_css('posted_at').text
      job.save
    end
  end
end
