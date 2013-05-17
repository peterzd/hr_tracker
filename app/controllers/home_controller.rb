class HomeController < ApplicationController
  def index
    if employee_signed_in?
      redirect_to home_dashboard_path
    end
  end

  def dashboard
  end
end
