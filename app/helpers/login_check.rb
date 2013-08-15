
helpers do
  def login_check
    user = User.find(session[:user_id]) rescue nil
  end
end
