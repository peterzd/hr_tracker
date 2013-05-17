class Contract < ActiveRecord::Base
  belongs_to :employee
  attr_accessible :end_date, :salary, :start_date, :employee

  scope :current_employee_contracts, lambda { |employee| where(employee_id: employee.id)}
end
