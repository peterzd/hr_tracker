class ContractsController < ApplicationController
  authorize_resource

  def index
    @contracts = (can? :manage, Contract) ? (Contract.order :updated_at) : (Contract.current_employee_contracts current_employee)

  end

  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract }
    end
  end

  def new
    @contract = Contract.new
    @employees = Employee.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contract }
    end
  end

  def edit
    @contract = Contract.find(params[:id])
    @employees = Employee.all
  end

  def create
    @contract = Contract.new(constructed_contract params[:contract])

    if @contract.save
      redirect_to @contract, notice: 'Contract was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @contract = Contract.find(params[:id])

    if @contract.update_attributes(constructed_contract params[:contract])
      redirect_to @contract, notice: 'Contract was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end

  private
  def constructed_contract contract_params
    employee_id = contract_params.delete(:employee_id).to_i
    employee = Employee.find employee_id
    contract_params[:employee] = employee
    contract_params
  end
end
