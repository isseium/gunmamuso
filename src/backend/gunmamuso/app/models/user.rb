class User < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :secret, :token, :uid
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      # user.name =auth["user_info"]["name"]
      user.name =auth["info"]["name"]
      # user.screen_name = auth["user_info"]["nickname"]
      user.screen_name = auth["info"]["nickname"]
      user.token = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
    end
  end
end
