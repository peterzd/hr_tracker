class Bonus < ActiveRecord::Base
  belongs_to :employee
  attr_accessible :amount, :comment, :distribution_date
end
