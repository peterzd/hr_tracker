class SalaryActivity < ActiveRecord::Base
  belongs_to :contract
  has_one :discusstion

  attr_accessible :current_salary, :discusstion_date, :effective_date, :previous_salary, :contract
end
