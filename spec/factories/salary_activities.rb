# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :salary_activity do
    previous_salary 1.5
    current_salary 1.5
    contract nil
    discusstion_date "2013-05-19"
    effective_date "2013-05-19"
  end
end
