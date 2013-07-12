class Note < ActiveRecord::Base
  belongs_to :employee, class_name: 'Employee'
  belongs_to :creator, class_name: 'Employee'
  attr_accessible :content, :title, :employee, :creator

end
