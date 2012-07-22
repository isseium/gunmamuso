class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    pp session
    redirect_to root_url + 'shake.html?id=' + user.id.to_s, :notice => "login"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "logout"
  end
end
