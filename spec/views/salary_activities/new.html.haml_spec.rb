require 'spec_helper'

describe "salary_activities/new" do
  before(:each) do
    assign(:salary_activity, stub_model(SalaryActivity,
      :previous_salary => 1.5,
      :current_salary => 1.5,
      :contract => nil
    ).as_new_record)
  end

  it "renders new salary_activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", salary_activities_path, "post" do
      assert_select "input#salary_activity_previous_salary[name=?]", "salary_activity[previous_salary]"
      assert_select "input#salary_activity_current_salary[name=?]", "salary_activity[current_salary]"
      assert_select "input#salary_activity_contract[name=?]", "salary_activity[contract]"
    end
  end
end
