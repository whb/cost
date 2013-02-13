class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_organization
    @current_organization ||= current_user.organization if current_user
    @current_organization == nil ? Organization.nil_object : @current_organization
  end
  
  helper_method :current_user, :current_organization
end
