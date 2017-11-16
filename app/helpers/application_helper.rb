module ApplicationHelper
  include SessionsHelper

  def member_or_hidden(post)
    user_logged_in? ? post.user.username : 'hidden'
  end

  def logged_in_user
    redirect_to login_url unless user_logged_in?
  end
end
