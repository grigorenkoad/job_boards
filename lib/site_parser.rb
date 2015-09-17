require 'parser'
require 'open-uri'
require 'nokogiri'
class SiteParser < Parser

  def self.parse(url)
    page = Nokogiri::HTML(open(url))
    count_page = page.css('select#iCIMS_Paginator option:last-child')
    count_page = 12
    jobs = []
    binding.pry
    count_page.times do |page_num|
      jobs << self.parse_page(page_num) 
    end  
  end

  def self.parse_page(num)
    url = 'https://careers-deltaed.icims.com/jobs/search?pr=#{num - 1}&in_iframe=1'
    urll = 'https://careers-deltaed.icims.com/jobs/search?pr='+(num-1).to_s+'&in_iframe=1'
    page = Nokogiri::HTML(open(url))
    page.css('table tr').each do |item|
      self.parse_jobs(item)
    end
  end

  def self.parse_jobs(item)
    job = Job.new
    job[:req_num] = item.css('td:nth-child(1)').text.sub('Req #:','')
    job[:title] = item.css('td:nth-child(2) a').text
    link = item.css('td:nth-child(2) a').map { |link| link['href']}
    job[:url] = link.first
    job[:location] = item.css('td:nth-child(4) span:nth-child(2)').text
    job[:company] = item.css('td:nth-child(3)').text.sub('Campus:','') 
    job[:category] = item.css('td:nth-child(5)').text.sub('Category:','') 
    job[:posted_at] = item.css('td:nth-child(6)').text.sub('Posted Date:','')  
    if !job.save! 
      logger.debug("unable to save job = #{job.inspect}") unless jobs.save
  end

end
