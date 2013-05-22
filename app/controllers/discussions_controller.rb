class DiscussionsController < ApplicationController
  def new_or_edit
    @contract = Contract.find params[:contract_id]
    @salary_activity = SalaryActivity.find params[:salary_activity_id]
    @discussion = @salary_activity.discussion

    if @discussion.nil?
      @discussion = @salary_activity.build_discussion
    end
  end

  def create_or_update
    @contract = Contract.find params[:contract_id]
    @salary_activity = SalaryActivity.find params[:salary_activity_id]

    @discussion = @salary_activity.build_discussion(params[:discussion])

    if @discussion.save
      redirect_to edit_contract_salary_activity_path(@contract, @salary_activity)
    end
  end
end
