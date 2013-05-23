class BonusesController < ApplicationController
  def index
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
    @bonus = Bonus.find params[:id]
    @action = { action: "update" }
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
