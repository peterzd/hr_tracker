class BonusesController < ApplicationController
  def index
    @employee = Employee.where(nickname: params[:nickname].strip).first
    @bonuses = @employee.bonuses
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
end
