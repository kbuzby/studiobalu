module SessionsHelper

  def log_in(user)
    session[:user] = user.username
  end

  def log_out
    session.delete(:user)
    @current_user = nil
  end

  def current_user
    @current_user ||= session[:user]
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    logged_in? && !Admin.find_by(username: current_user).nil?
  end

end
