class SessionsController < ApplicationController

  def new
  end

  def create

    user = Admin.find_by(username: params[:session][:username].downcase)

    if user && user.authenticate(params[:session][:pass])
      log_in user
      redirect_to root_url
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
