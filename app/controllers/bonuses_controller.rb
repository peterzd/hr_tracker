class BonusesController < ApplicationController
  before_filter :authorize_employee
  load_and_authorize_resource through: :current_employee
  add_breadcrumb 'home', :home_index_path

  def index
    add_breadcrumb 'bonuses'
    @employee = Employee.where(nickname: params[:nickname].strip).first
    @bonuses = @employee.bonuses
  end

  def new
    employee = Employee.where(nickname: params[:nickname].strip).first
    @bonus = employee.bonuses.build
  end

  def create
    employee = Employee.where(nickname: params[:nickname].strip).first
    @bonus = employee.bonuses.build(params[:bonus])

    if @bonus.save
      redirect_to bonuses_path
    end

  end

  def edit
    employee = Employee.where(nickname: params[:nickname].strip).first
    @action = { action: "update" }
    add_breadcrumb 'bonuses', bonuses_path
    add_breadcrumb "#{employee.nickname}"

  end

  def update
    employee = Employee.where(nickname: params[:nickname].strip).first
    @bonus = employee.bonuses.find params[:id]

    if @bonus.update_attributes(params[:bonus])
      redirect_to bonuses_path(employee.nickname)
    end
  end

  def destroy
    @bonus = Bonus.find params[:id]
    @bonus.destroy

    redirect_to bonuses_path
  end

  def emp_bonuses
    @bonuses = @employee.bonuses
    @operations = false
  end

  private
  def authorize_employee
    @employee = Employee.where(nickname: params[:nickname].strip).first
    authorize! :show, @employee
  end
end
