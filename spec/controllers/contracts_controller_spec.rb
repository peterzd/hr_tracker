require 'spec_helper'

describe ContractsController do

  # This should return the minimal set of attributes required to create a valid
  # Contract. As you add validations to Contract, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "start_date" => "2013-05-16" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContractsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all contracts as @contracts" do
      contract = Contract.create! valid_attributes
      get :index, {}, valid_session
      assigns(:contracts).should eq([contract])
    end
  end

  describe "GET show" do
    it "assigns the requested contract as @contract" do
      contract = Contract.create! valid_attributes
      get :show, {:id => contract.to_param}, valid_session
      assigns(:contract).should eq(contract)
    end
  end

  describe "GET new" do
    it "assigns a new contract as @contract" do
      get :new, {}, valid_session
      assigns(:contract).should be_a_new(Contract)
    end
  end

  describe "GET edit" do
    it "assigns the requested contract as @contract" do
      contract = Contract.create! valid_attributes
      get :edit, {:id => contract.to_param}, valid_session
      assigns(:contract).should eq(contract)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contract" do
        expect {
          post :create, {:contract => valid_attributes}, valid_session
        }.to change(Contract, :count).by(1)
      end

      it "assigns a newly created contract as @contract" do
        post :create, {:contract => valid_attributes}, valid_session
        assigns(:contract).should be_a(Contract)
        assigns(:contract).should be_persisted
      end

      it "redirects to the created contract" do
        post :create, {:contract => valid_attributes}, valid_session
        response.should redirect_to(Contract.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contract as @contract" do
        # Trigger the behavior that occurs when invalid params are submitted
        Contract.any_instance.stub(:save).and_return(false)
        post :create, {:contract => { "start_date" => "invalid value" }}, valid_session
        assigns(:contract).should be_a_new(Contract)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Contract.any_instance.stub(:save).and_return(false)
        post :create, {:contract => { "start_date" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contract" do
        contract = Contract.create! valid_attributes
        # Assuming there are no other contracts in the database, this
        # specifies that the Contract created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Contract.any_instance.should_receive(:update_attributes).with({ "start_date" => "2013-05-16" })
        put :update, {:id => contract.to_param, :contract => { "start_date" => "2013-05-16" }}, valid_session
      end

      it "assigns the requested contract as @contract" do
        contract = Contract.create! valid_attributes
        put :update, {:id => contract.to_param, :contract => valid_attributes}, valid_session
        assigns(:contract).should eq(contract)
      end

      it "redirects to the contract" do
        contract = Contract.create! valid_attributes
        put :update, {:id => contract.to_param, :contract => valid_attributes}, valid_session
        response.should redirect_to(contract)
      end
    end

    describe "with invalid params" do
      it "assigns the contract as @contract" do
        contract = Contract.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contract.any_instance.stub(:save).and_return(false)
        put :update, {:id => contract.to_param, :contract => { "start_date" => "invalid value" }}, valid_session
        assigns(:contract).should eq(contract)
      end

      it "re-renders the 'edit' template" do
        contract = Contract.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contract.any_instance.stub(:save).and_return(false)
        put :update, {:id => contract.to_param, :contract => { "start_date" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contract" do
      contract = Contract.create! valid_attributes
      expect {
        delete :destroy, {:id => contract.to_param}, valid_session
      }.to change(Contract, :count).by(-1)
    end

    it "redirects to the contracts list" do
      contract = Contract.create! valid_attributes
      delete :destroy, {:id => contract.to_param}, valid_session
      response.should redirect_to(contracts_url)
    end
  end

end
