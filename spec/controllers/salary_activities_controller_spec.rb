require 'spec_helper'

describe SalaryActivitiesController do
	helper_objects

	describe "GET dashboard_ajax_new" do
		context "logged in as admin" do
			before :each do
				sign_in sameer
				@peter_contract_0 = create(:contract, start_date: 2.years.ago, end_date: 1.years.ago, salary: 4000, employee: peter)
				@peter_contract = create(:contract, start_date: 1.years.ago, end_date: 2.years.from_now, salary: 5000, employee: peter)
				get :dashboard_ajax_new, nickname: peter.nickname, format: :js
			end

			it "works" do
				response.should be_success
			end

			it "assigns a new salary activity" do
				assigns[:salary_activity].should be_new_record
			end

			it "attaches the new salary activity to the lastest contract" do
				assigns[:salary_activity].contract.should eq @peter_contract
			end

			it "creates a new discussion" do
				assigns[:discussion].should be_new_record
			end

			it "initialize the previous salary amount" do
				assigns[:salary_activity].previous_salary.should eq 4000
			end
		end

		context "sign in as normal employee" do
			before :each do
				sign_in allen
			end

			it "does not allow to access" do
				get :dashboard_ajax_new, nickname: peter.nickname, format: :js
				response.status.should eq 401
			end
		end
	end

end
