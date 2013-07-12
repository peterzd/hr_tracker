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

	scenario "shows the bonuses for the employee", js: true do
		bonus_1 = create(:bonus, amount: 3000, distribution_date: Date.new(2011, 12, 30))
		bonus_2 = create(:bonus, amount: 5000, distribution_date: Date.new(2012, 5, 28))
		peter.bonuses << [bonus_1, bonus_2]
		# click the 'View Bonuses' button
		within("#high") { find('button.dropdown-toggle').click }
		click_link('View Bonuses')

		page.should have_css('table.table-striped')

		# the table shold have 3 trs
		within('table.table-striped') do
			expect(all('tr').count).to eq 3
		end

		# dismiss the modal
		click_link('Close')
		page.find('table.table-striped').should_not be_visible
	end

	context "navigating on the top-right corner", js: true do
		scenario 'go to employees page' do
			within('#user_session') do
				click_link 'Todo'
				page.should have_content 'Employees'

				click_link 'Employees'
				current_path.should == employees_path
			end
		end

		scenario 'go to contracts page' do
			within '#user_session' do
				click_link 'Todo'
				page.should have_content 'Contracts'
				click_link 'Contracts'
				current_path.should == contracts_path
			end
		end
	end

	scenario "creating a new draft contract", js: true do

		# show the new contract modal for peter
		within("#high") { find('button.dropdown-toggle').click }
		click_link('New Contract')
		page.should have_css ('form#new_contract')

		# fill in the data
		page.first('i.icon-time').click
		page.find('div.datetimepicker-days').first('td.day', text: '1').click
		page.find('#contract_end_date').click
		page.find('div.datetimepicker-days').all('td.day', text: '28').last.click
		fill_in('contract[salary]', with: '55555')

		# Save the contract as Draft
		click_on 'Save as Draft'
		page.should_not have_css ('form#new_contract')

		# verify the DB
		peter.reload.should have(2).contracts
		peter.contracts.last.should be_draft

		# verify the UI, the days for peter is still 21
		within('#high') do
			find('div.days').should have_content '21 days'
		end
	end

	scenario "show notes for employee", js: true do
    create(:note, title: 'first note', employee: peter, content: 'test', creator: sameer)
    create(:note, title: 'second note', employee: peter, content: 'test_2', creator: sameer)

		within("#high") { find('button.dropdown-toggle').click }
    click_link 'Notes'

		page.should have_css('div#notes-modal')

		page.should have_css('#notes-panel')
		within('#notes-panel') do
			find('h2', text: 'Notes For peter')
      find('table.table').all('tr').count.should == 3

      click_on 'Create New Note'

      page.should have_css('#new-note-modal')

      #within('#new-note-modal') do
      #  find('form#new_note')
      #  find('save note').click
      #end
		end



	end
end
