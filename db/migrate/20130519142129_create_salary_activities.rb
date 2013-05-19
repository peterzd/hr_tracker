class CreateSalaryActivities < ActiveRecord::Migration
  def change
    create_table :salary_activities do |t|
      t.float :previous_salary
      t.float :current_salary
      t.references :contract
      t.date :discusstion_date
      t.date :effective_date

      t.timestamps
    end
    add_index :salary_activities, :contract_id
  end
end
