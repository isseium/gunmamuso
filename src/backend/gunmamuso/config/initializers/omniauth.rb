Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "consumer key", "consumer secret"
end
