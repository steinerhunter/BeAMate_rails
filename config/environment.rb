# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BeAMateRails::Application.initialize!

# This is part of the feedback
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
    :address            => "smtp.sendgrid.net",
    :port                   => 587,
    :domain              => "beamate.com",
    :user_name       =>  ENV['SENDGRID_USERNAME'],
    :password         =>  ENV['SENDGRID_PASSWORD'],
    :authentication       => :plain,
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options = {
    :host => "www.beamate.com"
}