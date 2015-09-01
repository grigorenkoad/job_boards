module JobsHelper
  def filter_jobs(jobs, filter)
    @right_jobs = jobs
    @right_jobs = @right_jobs.where(:title => filter[:title]) if filter[:title].present?
    @right_jobs = @right_jobs.where(:location => filter[:location]) if filter[:location].present?
    @right_jobs = @right_jobs.where(:company => filter[:company]) if filter[:company].present?
    @right_jobs = @right_jobs.where(:category => filter[:category]) if filter[:category].present?
    @jobs = @right_jobs
  end
end
