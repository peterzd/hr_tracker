class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(user)
    employees_path
  end

  # set cancan default current_user to current_employee
  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
