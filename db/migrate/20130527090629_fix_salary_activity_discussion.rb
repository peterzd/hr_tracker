class FixSalaryActivityDiscussion < ActiveRecord::Migration
  def change
    rename_column :salary_activities, :discusstion_date, :discussion_date
  end

end
