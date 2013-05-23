# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bonu, :class => 'Bonus' do
    amount 1.5
    distribution_date "2013-05-22"
    comment "MyText"
    employee nil
  end
end
