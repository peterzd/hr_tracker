require 'spec_helper'

describe "contracts/new" do
  before(:each) do
    assign(:contract, stub_model(Contract,
      :salary => 1.5,
      :employee => nil
    ).as_new_record)
  end

  it "renders new contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contracts_path, "post" do
      assert_select "input#contract_salary[name=?]", "contract[salary]"
      assert_select "input#contract_employee[name=?]", "contract[employee]"
    end
  end
end
