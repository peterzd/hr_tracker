class EmployeesController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb "home", :home_index_path

  def index
    @employees = Employee.order :id
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
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  def edit
    add_breadcrumb "#{current_employee.nickname}", employee_path(current_employee)
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(params[:employee])
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end
end
