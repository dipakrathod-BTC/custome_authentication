require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CustomeAuthentication
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    binding.pry
    if Rails.env.development?
      config.action_mailer.smtp_settings = {
        address: 'smtp.gmail.com',
        port: 587,
        domain: Rails.application.credentials.mailer_settings[:domain],
        user_name: Rails.application.credentials.mailer_settings[:email],
        password: Rails.application.credentials.mailer_settings[:password],
        authentication: :plain,
        enable_starttls_auto: true
      }
    end

    if Rails.env.production?
      config.action_mailer.smtp_settings = {
        address: 'smtp.gmail.com',
        port: 587,
        domain: ENV['MAIL_DOMAIN'],
        user_name: ENV['USEREMAIL'],
        password: ENV['PASSWORD'],
        authentication: :plain,
        enable_starttls_auto: true
      }
    end
  end
end
