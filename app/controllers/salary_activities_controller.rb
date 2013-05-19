class SalaryActivitiesController < ApplicationController
  def index
    @salary_activities = SalaryActivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salary_activities }
    end
  end

  def show
    @salary_activity = SalaryActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary_activity }
    end
  end

  def new
    @contract = Contract.where(id: params[:contract_id]).first
    @salary_activity = @contract.salary_activities.build
  end

  def edit
    @salary_activity = SalaryActivity.find(params[:id])
  end

  def create
    @contract = Contract.where(id: params[:contract_id]).first
    params[:salary_activity][:contract] = @contract
    @salary_activity = SalaryActivity.new(params[:salary_activity])

    respond_to do |format|
      if @salary_activity.save
        redirect_to contract_salary_activities_path(@contract), notice: 'Salary activity was successfully created.'
      else
        render action: "new"
      end
    end
  end

  def update
    @salary_activity = SalaryActivity.find(params[:id])

    respond_to do |format|
      if @salary_activity.update_attributes(params[:salary_activity])
        format.html { redirect_to @salary_activity, notice: 'Salary activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salary_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salary_activities/1
  # DELETE /salary_activities/1.json
  def destroy
    @salary_activity = SalaryActivity.find(params[:id])
    @salary_activity.destroy

    respond_to do |format|
      format.html { redirect_to salary_activities_url }
      format.json { head :no_content }
    end
  end
end
