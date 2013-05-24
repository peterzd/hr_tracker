class HomeController < ApplicationController
  # authorize_resource :employee

  def index
    if employee_signed_in?
      redirect_to home_dashboard_path
    end
  end

  def dashboard
    @employees = Employee.order :id
  end
end
