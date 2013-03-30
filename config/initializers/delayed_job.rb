# Options
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 2
Delayed::Worker.max_attempts = 5
Delayed::Worker.max_run_time = 1.hour
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))

if Rails.env.development?
  system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} stop"
  system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} start"
elsif Rails.env.production?
  system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} stop"
  system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} start"
end