class SalaryActivitiesController < ApplicationController
  # GET /salary_activities
  # GET /salary_activities.json
  def index
    @salary_activities = SalaryActivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salary_activities }
    end
  end

  # GET /salary_activities/1
  # GET /salary_activities/1.json
  def show
    @salary_activity = SalaryActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary_activity }
    end
  end

  # GET /salary_activities/new
  # GET /salary_activities/new.json
  def new
    @salary_activity = SalaryActivity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salary_activity }
    end
  end

  # GET /salary_activities/1/edit
  def edit
    @salary_activity = SalaryActivity.find(params[:id])
  end

  # POST /salary_activities
  # POST /salary_activities.json
  def create
    @salary_activity = SalaryActivity.new(params[:salary_activity])

    respond_to do |format|
      if @salary_activity.save
        format.html { redirect_to @salary_activity, notice: 'Salary activity was successfully created.' }
        format.json { render json: @salary_activity, status: :created, location: @salary_activity }
      else
        format.html { render action: "new" }
        format.json { render json: @salary_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /salary_activities/1
  # PUT /salary_activities/1.json
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
