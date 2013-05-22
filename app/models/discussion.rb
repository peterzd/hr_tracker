class Discussion < ActiveRecord::Base
  belongs_to :salary_activity
  attr_accessible :content, :is_visible
end
