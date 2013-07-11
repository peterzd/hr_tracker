require 'spec_helper'

describe Employee do
  helper_objects

  it 'sameer is the system_admin' do
    sameer.is_system_admin.should be_true
  end

	context "#employees_with_expired" do
		before :each do
			Employee.delete_all
			@peter_contract = create(:contract, employee: peter, end_date: 20.days.from_now)
			@sameer_contract = create(:contract, employee: sameer, end_date: 70.days.from_now)
			@allen_contract = create(:contract, employee: allen, end_date: 99.days.from_now)
		end

		it "returns the hash of employee with days of scale from end_date to today" do
			Employee.send(:employees_with_expired).should == { peter => 20, sameer => 70, allen => 99 }
		end

		it "does not include the draft contract" do
			peter_contract_2 = create(:contract, employee: peter, end_date: 10.days.from_now, draft: true)
			Employee.send(:employees_with_expired)[peter].should == 20
		end
	end

	context "different priorities of employees" do
		before :each do
			Employee.delete_all
			@peter_contract = create(:contract, employee: peter, end_date: 20.days.from_now)
			@sameer_contract = create(:contract, employee: sameer, end_date: 70.days.from_now)
			@allen_contract = create(:contract, employee: allen, end_date: 99.days.from_now)
		end

		it "groups the employee-days within 50 days to high_priority"  do
			expect(Employee.high_priority.keys.count).to eq 1
			expect(Employee.high_priority.keys).to include peter
		end

		it "does not include the draft contract" do
			peter_contract_2 = create(:contract, employee: peter, end_date: 10.days.from_now, draft: true)
			expect(Employee.high_priority[peter]).to eq 20
		end
		
	end
end
