require 'spec_helper'

def login_admin
  login_as(sameer, scope: :employee)
end

describe "Contracts" do
  helper_objects

  before :each do
    login_admin
    visit contracts_path
  end

  describe "GET /contracts" do

    it "Lists all the contracts" do
      page.should have_content 'Listing contracts'
    end
  end

  describe "operations" do
    before :each do
      first(:link, 'Operations').click
    end

    it "shows operations for choose" do
      page.should have_content 'Show'
    end

    context "Destroy" do
      it "removes the contract", js: true do
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        page.should have_content 'Listing contracts'
      end
    end

    context "Edit" do
      it "redirects to the edit page" do
        first(:link, 'Edit').click
        get_via_redirect edit_contract_path(contract_sameer)
        page.should have_content 'Editing contract'
      end
    end
  end

end
