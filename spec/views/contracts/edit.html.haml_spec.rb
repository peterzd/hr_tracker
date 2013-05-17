require 'spec_helper'

describe "contracts/edit" do
  before(:each) do
    @contract = assign(:contract, stub_model(Contract,
      :salary => 1.5,
      :employee => nil
    ))
  end

  it "renders the edit contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contract_path(@contract), "post" do
      assert_select "input#contract_salary[name=?]", "contract[salary]"
      assert_select "input#contract_employee[name=?]", "contract[employee]"
    end
  end
end
