if Rails.env.development?
  # Use mailcatcher in development
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings   = {
    host: 'localhost',
    port: 1025
  }
else
  # Use smtp configuration defined in /config/lbc.yml
  ActionMailer::Base.delivery_method       = :smtp
  ActionMailer::Base.perform_deliveries    = true
  ActionMailer::Base.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
    address:              Settings.emails.smtp.address,
    port:                 Settings.emails.smtp.port,
    domain:               Settings.emails.smtp.domain,
    user_name:            Settings.emails.smtp.user_name,
    password:             Settings.emails.smtp.password,
    authentication:       Settings.emails.smtp.authentication,
    enable_starttls_auto: true
  }
end

ActionMailer::Base.default_options     = { from: Settings.emails.default_sender }
ActionMailer::Base.default_url_options = {
  host: Settings.host,
  port: Settings.port
}
