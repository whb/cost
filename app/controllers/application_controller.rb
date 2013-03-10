class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  before_filter :instantiate_controller_and_action_names
  before_filter :login_required

  private

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_organization
    @current_organization ||= current_user.organization if current_user
    @current_organization == nil ? Organization.nil_object : @current_organization
  end

  helper_method :current_user, :current_organization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def begin_to_end_of(month)
    this_year = Date.today.year
    begin_date = Date.new(this_year, month, 1)
    if (month == 12)
      end_date = Date.new(this_year + 1, 1, 1)
    else
      end_date = Date.new(this_year, month+1, 1)
    end
    return begin_date...end_date
  end
end
