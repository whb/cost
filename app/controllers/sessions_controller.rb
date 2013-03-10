class SessionsController < ApplicationController
  skip_authorization_check
  skip_before_filter :login_required  
  
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => t("Logged in!")
    else
      flash.now.alert = t("Invalid username or password")
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => t("Logged out!")
  end
end
