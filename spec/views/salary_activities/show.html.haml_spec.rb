require 'spec_helper'

describe "salary_activities/show" do
  before(:each) do
    @salary_activity = assign(:salary_activity, stub_model(SalaryActivity,
      :previous_salary => 1.5,
      :current_salary => 1.5,
      :contract => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(//)
  end
end
