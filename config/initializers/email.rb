if RAILS_ENV != 'test'
  email_settings = YAML::load(File.open("#{RAILS_ROOT}/config/email.yml"))
  unless email_settings[RAILS_ENV].nil?
    ActionMailer::Base.smtp_settings = email_settings[RAILS_ENV]
    ActionMailer::Base.default_url_options[:host] = email_settings[RAILS_ENV][:host]
  end
end