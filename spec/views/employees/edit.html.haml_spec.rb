require 'spec_helper'

describe "employees/edit" do
  before(:each) do
    @employee = assign(:employee, stub_model(Employee,
      :name => "MyString",
      :nickname => "MyString",
      :current_employee => false,
      :years_prior_exp => 1,
      :university => "MyString",
      :degree => "MyString",
      :is_system_admin => false,
      :is_admin => false
    ))
  end

  it "renders the edit employee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", employee_path(@employee), "post" do
      assert_select "input#employee_name[name=?]", "employee[name]"
      assert_select "input#employee_nickname[name=?]", "employee[nickname]"
      assert_select "input#employee_current_employee[name=?]", "employee[current_employee]"
      assert_select "input#employee_years_prior_exp[name=?]", "employee[years_prior_exp]"
      assert_select "input#employee_university[name=?]", "employee[university]"
      assert_select "input#employee_degree[name=?]", "employee[degree]"
      assert_select "input#employee_is_system_admin[name=?]", "employee[is_system_admin]"
      assert_select "input#employee_is_admin[name=?]", "employee[is_admin]"
    end
  end
end
