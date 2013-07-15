require 'spec_helper'

describe ContractsController do
  helper_objects

  describe "GET index" do

    context "logged in as system admin" do

      before :each do
        [contract_sameer, contract_peter, contract_peter_2, contract_allen, contract_andy].each(&:save)
        sign_in sameer
      end

      it "assigns all the contracts" do
        get :index
        assigns[:contracts].count.should == 5
      end
    end

    context "logged in as normal employee" do
      before :each do
        sign_in peter
      end

      it "just assigns the contacts which belongs to him"
    end
  end

	describe "POST create" do
		before :each do
			sign_in sameer
		end

		context "with 'Save' button" do
			it "creates a normal contract" do
				post :create, contract: attributes_for(:contract, employee_id: peter.id), commit: 'Save', from: 'dashboard', format: :js
				peter.reload.should have(1).contracts
				peter.contracts.first.should_not be_draft
			end
		end

		context "with 'Save as Draft' button" do
			it "creates a draft contract" do
				post :create, contract: attributes_for(:contract, employee_id: peter.id), commit: 'Save as Draft', from: 'dashboard', format: :js
				peter.reload.should have(1).contracts
				peter.contracts.first.should be_draft
			end
		end
	end
end
