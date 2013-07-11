require 'spec_helper'

describe HomeController do
	helper_objects

  describe "GET 'dashboard'" do
		before :each do
			Employee.delete_all
			sign_in sameer
			peter_contract = create(:contract, employee: peter, end_date: 20.days.from_now)
			sameer_contract = create(:contract, employee: sameer, end_date: 70.days.from_now)
			allen_contract = create(:contract, employee: allen, end_date: 99.days.from_now)
		end

		it "shows the days between the end_date of the latest contract with today" do
			get :dashboard
			assigns[:high_employees].keys.should include peter
			assigns[:high_employees].values.should include 20
		end

		it "does not include the draft contract to the employee-days" do
			peter_contract = create(:contract, employee: peter, end_date: 35.days.from_now, draft: true)
			get :dashboard
			assigns[:high_employees].keys.should include peter
			assigns[:high_employees].values.should include 20
			assigns[:high_employees].values.should_not include 35
		end

  end

  describe "GET 'index'" do
  end

end
