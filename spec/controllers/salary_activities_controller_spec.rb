require 'spec_helper'

describe SalaryActivitiesController do
	helper_objects

	describe "GET dashboard_ajax_new" do
		context "logged in as admin" do
			before :each do
				sign_in sameer
				get :dashboard_ajax_new, nickname: peter.nickname, format: :js
			end

			it "works" do
				response.should be_success
			end

			it "gets the employee" do
				get :dashboard_ajax_new, nickname: peter.nickname, format: :js
				assigns[:employee].should eq peter
			end

			it "assigns a new salary activity" do
				get :dashboard_ajax_new, nickname: peter.nickname, format: :js
				assigns[:salary_activity].should be_new_record
			end

			it "attaches the new salary activity to the lastest contract"

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
