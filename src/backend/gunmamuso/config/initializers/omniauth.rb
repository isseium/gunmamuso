Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "394868037240594", "f382ca207fcf7b632448598cdbbd36c5", {:scope => 'publish_stream'}
end
