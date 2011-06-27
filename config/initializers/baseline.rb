module Baseline
  AppName = 'CsvTest'
  DefaultHost = 'csvtest.com'
  EmailSender = "#{AppName} <noreply@#{DefaultHost}>"

  if defined?(Rails)
    if Rails.env.production?
      ActionMailer::Base.default_url_options[:host] = DefaultHost
    else
      ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
    end
  end
end
