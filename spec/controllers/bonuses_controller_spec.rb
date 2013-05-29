require 'spec_helper'

describe BonusesController do

  describe "GET 'index'" do

    context "logged in as system admin" do
      login_admin

      it "lists all the bonus of this employee" do
        subject.current_employee.should_not be_nil
      end

      it "has the system admin privilege" do
        subject.current_employee.is_system_admin.should be_true
      end
    end

    context "logged in as the owner employee"

    context "logged in as other common employees"

  end
=begin
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end
=end
end
