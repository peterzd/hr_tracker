class SalaryActivitiesController < ApplicationController
  authorize_resource
  load_resource :contract, except: [:create, :update]

  add_breadcrumb "home", :home_index_path

  def index
    add_breadcrumb "salary activities for #{@contract.id}"
    @salary_activities = @contract.salary_activities.order :effective_date
  end

  def show
    @salary_activity = SalaryActivity.find(params[:id])
    add_breadcrumb "salary activities for #{@contract.id}", contract_salary_activities_path(@contract)
    add_breadcrumb "#{@salary_activity.id}"
  end

  def new
    @contract = Contract.where(id: params[:contract_id]).first
    last_activity = SalaryActivity.last
    previous_salary = last_activity.current_salary unless last_activity.nil?
    @salary_activity = @contract.salary_activities.new(previous_salary: previous_salary)
    @discussion = Discussion.new
    add_breadcrumb "salary activities for #{@contract.id}", contract_salary_activities_path(@contract)
    add_breadcrumb "new"
  end

  def edit
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = SalaryActivity.find(params[:id])
    @discussion = @salary_activity.discussion || @salary_activity.build_discussion
    add_breadcrumb "salary activities for #{@contract.id}", contract_salary_activities_path(@contract)
    add_breadcrumb "#{@salary_activity.id}"
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
      @discussion = @salary_activity.build_discussion(params[:discussion])
      if @discussion.save
        redirect_to contract_salary_activities_path(@contract), notice: 'Salary activity was successfully created.'
      else
        render action: "new"
      end
    else
      render action: 'new'
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

      @discussion = @salary_activity.discussion.update_attributes(params[:discussion])
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
