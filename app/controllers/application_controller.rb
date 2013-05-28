class ApplicationController < ActionController::Base
  # add_breadcrumb 'home', :home_index_path

  protect_from_forgery
  def after_sign_in_path_for(user)
    home_dashboard_path
  end

  # set cancan default current_user to current_employee
  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'can not visit'
    redirect_to root_url, alert: exception.message
  end
end
