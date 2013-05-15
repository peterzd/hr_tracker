# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name "MyString"
    nickname "MyString"
    birthdate "2013-05-15"
    originate_start_date "2013-05-15"
    originate_end_date "2013-05-15"
    current_employee false
    years_prior_exp 1
    university "MyString"
    degree "MyString"
    is_system_admin false
    is_admin false
  end
end
