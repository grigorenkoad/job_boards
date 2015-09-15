module JobsHelper
  require 'open-uri'
  require 'nokogiri'

  def filter_jobs(jobs, filter)
    jobs = jobs.where(:title => filter[:title]) if filter[:title].present?
    jobs = jobs.where(:location => filter[:location]) if filter[:location].present?
    jobs = jobs.where(:company => filter[:company]) if filter[:company].present?
    jobs = jobs.where(:category => filter[:category]) if filter[:category].present?
    jobs
  end

  def self.parse_feed
    url = 'https://s3.amazonaws.com/masseria/peoplesoft/citizensbank.xml'
    page = Nokogiri::XML(open(url)) 
    page.css('job').each do |item|
      job = Job.new
      job[:title] = item.at_css('title').text
      job[:location] = item.at_css('country').text + ' / ' + item.at_css('state').text + ' / ' + item.at_css('city').text
      job[:company] = item.at_css('company').text
      job[:category] = item.at_css('category').text
      job[:url] = item.at_css('url').text
      job[:req_num] = item.at_css('req_number').text
      job[:posted_at] = item.at_css('posted_at').text
      job.save
    end
  end

  def parse_site
    jobs = []
    12.times do |page_num|
      jobs << parse_page(page_num) 
    end  
  end
  
  def parse_page(num)
    page = Nokogiri::HTML(open(('https://careers-deltaed.icims.com/jobs/search?pr='+(num-1).to_s+'&in_iframe=1')))
    page.css('table tr').each do |item|
      parse_jobs(item)
    end
  end

  def parse_jobs(item)
    jobs = Job.new
    jobs[:req_num] = item.css('td:nth-child(1)').text.sub('Req #:','')
    jobs[:title] = item.css('td:nth-child(2) a').text
    link = item.css('td:nth-child(2) a').map { |link| link['href']}
    jobs[:url] = link.first
    jobs[:location] = item.css('td:nth-child(4) span:nth-child(2)').text
    jobs[:company] = item.css('td:nth-child(3)').text.sub('Campus:','') 
    jobs[:category] = item.css('td:nth-child(5)').text.sub('Category:','') 
    jobs[:posted_at] = item.css('td:nth-child(6)').text.sub('Posted Date:','')  
    jobs.save
  end

end

