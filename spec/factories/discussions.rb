# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discussion do
    content "MyText"
    is_visible false
    salary_activity nil
  end
end
