# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contract do
    start_date "2013-05-16"
    end_date "2013-05-16"
    salary 1.5
    employee nil
  end
end
