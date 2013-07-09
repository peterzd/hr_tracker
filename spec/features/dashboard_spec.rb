require 'spec_helper'

def login_admin
  login_as(sameer, scope: :employee)
end

describe "Dashboard" do
  helper_objects

  before :each do
    Employee.delete_all
    login_admin
    create(:contract, employee: peter, end_date: 21.days.from_now)
    create(:contract, employee: sameer, end_date: 80.days.from_now)
    create(:contract, employee: allen, end_date: 100.days.from_now)
    create(:contract, employee: andy, end_date: 100.days.from_now)
    visit home_dashboard_path
  end

  it "shows all current employees" do
    # setup database
    # login goto page do the operation
    # verify the page& DB
    page.should have_content 'sameer'
    page.should have_content 'peter'
    page.should have_content 'allen'
  end

  it "does not show the former employees" do
    page.should_not have_content 'andy'
  end

  it "shows employee with remaining days" do
    page.should have_content '21 days'
  end

  it "shows employees groups by remaining days" do


    page.find('#high').should have_link 'peter'
    page.find('#medium').should have_link 'sameer'
    page.find('#low').should have_link 'allen'
  end

  context 'clicking on the employee name' do
    it 'goes to the employee_contracts page' do

      click_link 'peter'
      current_path.should == emp_contracts_path('peter')
    end
  end

end
