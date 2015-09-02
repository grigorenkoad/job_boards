module JobsHelper
  def filter_jobs(jobs, filter)
    jobs = jobs.where(:title => filter[:title]) if filter[:title].present?
    jobs = jobs.where(:location => filter[:location]) if filter[:location].present?
    jobs = jobs.where(:company => filter[:company]) if filter[:company].present?
    jobs = jobs.where(:category => filter[:category]) if filter[:category].present?
    jobs
  end
end
