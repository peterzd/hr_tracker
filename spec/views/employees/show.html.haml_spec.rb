require 'spec_helper'

describe "employees/show" do
  before(:each) do
    @employee = assign(:employee, stub_model(Employee,
      :name => "Name",
      :nickname => "Nickname",
      :current_employee => false,
      :years_prior_exp => 1,
      :university => "University",
      :degree => "Degree",
      :is_system_admin => false,
      :is_admin => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Nickname/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(/University/)
    rendered.should match(/Degree/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
