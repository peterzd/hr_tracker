class BonusesController < ApplicationController
  add_breadcrumb 'home', :home_index_path

  def index
    add_breadcrumb 'bonuses'
    @employee = Employee.where(nickname: params[:nickname].strip).first
    @bonuses = @employee.bonuses
  end

  def new
    employee = Employee.where(nickname: params[:nickname].strip).first
    @bonus = employee.bonuses.build
    add_breadcrumb 'bonuses', bonuses_path
    add_breadcrumb 'new'
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
    @bonus = Bonus.find params[:id]
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

end
