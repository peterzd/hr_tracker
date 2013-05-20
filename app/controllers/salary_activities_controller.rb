class SalaryActivitiesController < ApplicationController
  authorize_resource
  load_resource :contract, except: [:create, :update]

  def index
    @salary_activities = @contract.salary_activities.order :effective_date
  end

  def show
    @salary_activity = SalaryActivity.find(params[:id])
  end

  def new
    @contract = Contract.where(id: params[:contract_id]).first
    last_activity = SalaryActivity.last
    previous_salary = last_activity.current_salary unless last_activity.nil?
    @salary_activity = @contract.salary_activities.build(previous_salary: previous_salary)
  end

  def edit
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = SalaryActivity.find(params[:id])
  end

  def create
    @contract = Contract.where(id: params[:contract_id]).first
    params[:salary_activity][:contract] = @contract

    current_salary = params[:salary_activity][:current_salary].to_i
    current_salary = params[:salary_activity][:previous_salary].to_i if (current_salary.nil? or current_salary == 0)
    params[:salary_activity][:current_salary] = current_salary

    @salary_activity = SalaryActivity.new(params[:salary_activity])

    if @salary_activity.save
      @contract.update_attribute(:salary, @salary_activity.current_salary)
      redirect_to contract_salary_activities_path(@contract), notice: 'Salary activity was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = SalaryActivity.find(params[:id])

    params[:salary_activity][:contract] = @contract

    current_salary = params[:salary_activity][:current_salary].to_i
    current_salary = params[:salary_activity][:previous_salary].to_i if (current_salary.nil? or current_salary == 0)
    params[:salary_activity][:current_salary] = current_salary

    if @salary_activity.update_attributes(params[:salary_activity])

      @contract.update_attribute(:salary, @salary_activity.current_salary)
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
