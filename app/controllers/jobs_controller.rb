class JobsController < ApplicationController
  
  include JobsHelper
  require 'open-uri'
  require 'nokogiri'
  
  def index
    @jobs = filter_jobs(Job.all, params)
  end
  
  def filter
    @filters = request_params
    redirect_to root_path(@filters)
  end

  def feed
    url = 'https://s3.amazonaws.com/masseria/peoplesoft/citizensbank.xml'
    page = Nokogiri::XML(open(url)) 
    job = Job.new
    page.css('job').each do |item|
      job = Job.new
      job[:title] = item.at_css('title').text
      job[:location] = item.at_css('country').text + '/' + item.at_css('state').text + '/' + item.at_css('city').text
      job[:company] = item.at_css('company').text
      job[:category] = item.at_css('category').text
      job[:url] = item.at_css('url').text
      job[:req_num] = item.at_css('req_number').text
      job[:posted_at] = item.at_css('posted_at').text
      job.save
    end
    @jobs = Job.all

  end

  def request_params
    params.require(:job).permit(:title, :location, :company, :category)
  end
end
