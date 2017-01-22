class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def show
    if admin?
      @user = Admin.find_by(:username => session[:user])
    end
    #future implement other user home maybe?

  end

  def new
  end

  def create

    user = Admin.find_by(username: params[:session][:username].downcase)

    if user && user.authenticate(params[:session][:pass])
      log_in user
      if user.class.name == "Admin"
        redirect_to admin_path
      else
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid credentials"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
