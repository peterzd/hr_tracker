# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    title "MyString"
    content "MyText"
    employee nil
    creator nil
  end
end
