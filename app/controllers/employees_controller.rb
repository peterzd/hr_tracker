class EmployeesController < ApplicationController
  load_and_authorize_resource #find_by: :id

  add_breadcrumb "home", :home_index_path

  def index
    @employees = Employee.current_employees
  end

  def ajax_list_all
    @employees = Employee.all
  end

  def ajax_list_current
    @employees = Employee.current_employees
  end

  def show
    add_breadcrumb "employees", employees_path
    add_breadcrumb "#{current_employee.nickname}", employee_path(current_employee)

    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  def new
    add_breadcrumb "new"
    @employee = Employee.new

    respond_to do |format|
      format.html # new.js.haml.erb
      format.json { render json: @employee }
    end
  end

  def edit
    add_breadcrumb "#{current_employee.nickname}", employee_path(current_employee)
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(params[:employee])
      redirect_to employees_path, notice: 'Employee was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    @employees = Employee.current_employees

    render 'common_utils/destroy', locals: { table_name: 'table' }
  end
end
