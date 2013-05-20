class SalaryActivitiesController < ApplicationController
  authorize_resource
  load_resource :contract, except: [:create, :update]

  def index
    @salary_activities = @contract.salary_activities
  end

  def show
    @salary_activity = SalaryActivity.find(params[:id])
  end

  def new
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = @contract.salary_activities.build
  end

  def edit
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = SalaryActivity.find(params[:id])
  end

  def create
    @contract = Contract.where(id: params[:contract_id]).first
    params[:salary_activity][:contract] = @contract
    @salary_activity = SalaryActivity.new(params[:salary_activity])

    if @salary_activity.save
      redirect_to contract_salary_activities_path(@contract), notice: 'Salary activity was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = SalaryActivity.find(params[:id])

    params[:salary_activity][:contract] = @contract
    logger.info "the new params is : #{params[:salary_activity]}"

    if @salary_activity.update_attributes(params[:salary_activity])
      redirect_to contract_salary_activities_path(@contract), notice: 'Salary activity was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @salary_activity = SalaryActivity.find(params[:id])
    @salary_activity.destroy

    redirect_to contract_salary_activities_path(@contract)
  end
end
