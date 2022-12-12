# frozen_string_literal: true

return if !Rails.env.production?

Sentry.init do |config|
  config.dsn = 'https://7c928dc293a943968e10cee9ffd9130d@o4504311662116864.ingest.sentry.io/4504314601472000'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
