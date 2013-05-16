class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :nickname
      t.date :birthdate
      t.date :originate_start_date
      t.date :originate_end_date
      t.boolean :current_employee
      t.integer :years_prior_exp
      t.string :university
      t.string :degree
      t.boolean :is_system_admin
      t.boolean :is_admin

      t.timestamps
    end
  end
end
