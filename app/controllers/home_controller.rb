class HomeController < ApplicationController

  def index
    if employee_signed_in?
      flash[:error] = flash[:error] unless flash[:error].nil?
      redirect_to home_dashboard_path
    end
  end

  def dashboard
    add_breadcrumb "home", :root_path
    @employees = Employee.current_employees
  end
end
