require 'spec_helper'

describe "contracts/show" do
  before(:each) do
    @contract = assign(:contract, stub_model(Contract,
      :salary => 1.5,
      :employee => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(//)
  end
end
