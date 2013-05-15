require 'spec_helper'

describe "employees/index" do
  before(:each) do
    assign(:employees, [
      stub_model(Employee,
        :name => "Name",
        :nickname => "Nickname",
        :current_employee => false,
        :years_prior_exp => 1,
        :university => "University",
        :degree => "Degree",
        :is_system_admin => false,
        :is_admin => false
      ),
      stub_model(Employee,
        :name => "Name",
        :nickname => "Nickname",
        :current_employee => false,
        :years_prior_exp => 1,
        :university => "University",
        :degree => "Degree",
        :is_system_admin => false,
        :is_admin => false
      )
    ])
  end

  it "renders a list of employees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "University".to_s, :count => 2
    assert_select "tr>td", :text => "Degree".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
