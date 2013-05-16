class Contract < ActiveRecord::Base
  belongs_to :employee
  attr_accessible :end_date, :salary, :start_date, :employee
end
