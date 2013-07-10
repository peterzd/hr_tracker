require 'spec_helper'

def login_admin
  login_as(sameer, scope: :employee)
end

feature "Dashboard" do
  helper_objects

  background do
    Employee.delete_all
    login_admin
    create(:contract, employee: peter, end_date: 21.days.from_now)
    create(:contract, employee: sameer, end_date: 80.days.from_now)
    create(:contract, employee: allen, end_date: 100.days.from_now)
    create(:contract, employee: andy, end_date: 100.days.from_now)
    visit home_dashboard_path
  end

  scenario "shows all current employees" do
    # setup database
    # login goto page do the operation
    # verify the page& DB
    page.should have_content 'sameer'
    page.should have_content 'peter'
    page.should have_content 'allen'
  end

  scenario "does not show the former employees" do
    page.should_not have_content 'andy'
  end

  scenario "shows employee with remaining days" do
    page.should have_content '21 days'
  end

  scenario "shows employees groups by remaining days" do
    page.find('#high').should have_link 'peter'
    page.find('#medium').should have_link 'sameer'
    page.find('#low').should have_link 'allen'
  end

  context 'clicking on the employee name' do
    scenario 'goes to the employee_contracts page' do

      click_link 'peter'
      current_path.should == emp_contracts_path('peter')
    end
  end

  context 'filtering the employees', js: true do
    scenario 'hides the unmatched employees' do
      fill_in 'filter', with: 'peter'

      page.find("#low").should_not have_content 'allen'
      page.find("#medium").should_not have_content 'sameer'

    end
  end

  context "creating new contract for employee", js: true do

    scenario "creates a new contract for the employee" do
			# creating new contract for peter
			within("#high") { find('button.dropdown-toggle').click }
      click_link('New Contract')
      page.should have_css ('form#new_contract')

			# choose strat_date at first day of this month, end_date at the 30th day of next two months
			page.first('i.icon-time').click
			page.find('div.datetimepicker-days').first('td.day', text: '1').click
			page.find('#contract_end_date').click
			page.find('i.icon-arrow-right').click
			page.find('i.icon-arrow-right').click
			page.find('div.datetimepicker-days').all('td.day', text: '28').last.click

			fill_in('contract[salary]', with: '55555')
			click_on("Save")

			# wait for operation to complete
			page.find('#medium').should have_link 'peter'

			# verify DB
			expect(peter).to have(2).contracts
		end
  end
end
