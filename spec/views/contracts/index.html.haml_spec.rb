require 'spec_helper'

describe "contracts/index" do
  before(:each) do
    assign(:contracts, [
      stub_model(Contract,
        :salary => 1.5,
        :employee => nil
      ),
      stub_model(Contract,
        :salary => 1.5,
        :employee => nil
      )
    ])
  end

  it "renders a list of contracts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
