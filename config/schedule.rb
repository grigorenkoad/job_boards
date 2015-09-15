every 1.minutes do
  runner "JobsWorker.perform_async"
end
