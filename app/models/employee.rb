class Employee < ActiveRecord::Base
  attr_accessible :birthdate, :current_employee, :degree, :is_admin, :is_system_admin, :name, :nickname, :originate_end_date, :originate_start_date, :university, :years_prior_exp
end
