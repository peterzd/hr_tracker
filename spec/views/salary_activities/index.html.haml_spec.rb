require 'spec_helper'

describe "salary_activities/index" do
  before(:each) do
    assign(:salary_activities, [
      stub_model(SalaryActivity,
        :previous_salary => 1.5,
        :current_salary => 1.5,
        :contract => nil
      ),
      stub_model(SalaryActivity,
        :previous_salary => 1.5,
        :current_salary => 1.5,
        :contract => nil
      )
    ])
  end

  it "renders a list of salary_activities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
