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
    @high_employees = Employee.high_priority
    @medium_employees = Employee.medium_priority
    @low_employees = Employee.low_priority
    render layout: 'application', locals: { no_breadcrumbs: true }
  end

  def new_contract_modal
    @contract = Contract.new
    @selected_emp_id = params[:employee_id]
    @from = :dashboard
  end
end
