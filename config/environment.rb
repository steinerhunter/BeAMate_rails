# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BeAMateRails::Application.initialize!

# This is part of the feedback
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
    :address            => "smtp.zoho.com",
    :port                   => 465,
    :domain              => "beamate.com",
    :user_name       => "firstmate@beamate.com",
    :password         => "thiswillbeourflagship",
    :authentication       => :login,
    :ssl                  => true,
    :tls                  => true,
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options = {
    :host => "beamate.com"
}