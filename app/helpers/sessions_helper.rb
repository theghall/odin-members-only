module SessionsHelper
  def log_in(username, password)
    user = User.find_by(username: username)
    
    if user &&  user.authenticate(password)
      user.remember
      cookies.permanent[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
  end

  def user_logged_in?
    logged_in = current_user
  end

  def log_out
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = cookies[:user_id])
      remember_token = cookies[:remember_token]

      user = User.find_by(id: user_id)

      @current_user = user if user.remembered?(remember_token)
    end
  end
end
