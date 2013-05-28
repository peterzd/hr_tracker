class SalaryActivity < ActiveRecord::Base
  belongs_to :contract
  has_one :discussion

  attr_accessible :current_salary, :discussion_date, :effective_date, :previous_salary, :contract
end
