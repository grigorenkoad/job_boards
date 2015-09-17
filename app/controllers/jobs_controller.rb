class JobsController < ApplicationController
  
  include JobsHelper

  
  def index
    @count = Job.count
    @jobs = filter_jobs(Job.all, params)
  end
  
  def filter
    @filters = request_params
    redirect_to root_path(@filters)
  end

  def request_params
    params.require(:job).permit(:title, :location, :company, :category)
  end
end
