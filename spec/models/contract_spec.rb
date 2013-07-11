require 'spec_helper'

describe Contract do
	helper_objects

	it "lists all the contracts associated to the employee" do
		contract_peter
		contract_peter_2

		expect(Contract.emp_contracts(peter).count).to eq 2
	end

	it "shows the sentence of the contract" do
		contract_peter.to_s.should eq "peter's contract"
	end
end
