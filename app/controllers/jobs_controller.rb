class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
  end

  def found
    @found_jobs = Job.all
    @found_jobs = @found_jobs.title(request_params[:title]) if request_params[:title].present?
    @found_jobs = @found_jobs.location(request_params[:location]) if request_params[:location].present?
    @found_jobs = @found_jobs.company(request_params[:company]) if request_params[:company].present?
    @found_jobs = @found_jobs.category(request_params[:category]) if request_params[:category].present?
  end

  def request_params
    params.require(:request).permit(:title, :location, :company, :category)
  end
end
