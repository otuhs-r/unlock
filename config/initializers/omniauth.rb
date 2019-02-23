Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
           Rails.application.secrets.twitter_app[:consumer_key],
           Rails.application.secrets.twitter_app[:consumer_secret]
end
