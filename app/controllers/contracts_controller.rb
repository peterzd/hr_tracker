class ContractsController < ApplicationController
  load_and_authorize_resource except: [:create]

  add_breadcrumb 'home', :home_index_path

  def index
    add_breadcrumb "contracts"
    @contracts = (can? :manage, Contract) ? (Contract.order :updated_at) : (Contract.current_employee_contracts current_employee)
  end

  def show
    @contract = Contract.find(params[:id])
    add_breadcrumb "contracts", contracts_path
    add_breadcrumb "#{@contract.id}"
  end

  # def new
  #   @contract = Contract.new
  #   add_breadcrumb "contracts", contracts_path
  #   add_breadcrumb "new"
  # end

  def ajax_new
    @contract = Contract.new
    @from = 'contract'
  end

  def edit
    @contract = Contract.find(params[:id])
    add_breadcrumb "contracts", contracts_path
    add_breadcrumb "#{@contract.id}"
  end

  # ajax request. Used for two scenarios:
  # 1. request from dashboard.
  # 2. request from Contracts.
  def create
    @contract = Contract.new(constructed_contract params[:contract])
    from = params[:from].strip
		@contract.draft = true if params[:commit] == 'Save as Draft'

    # set a flag to distinguish where the request comes from
    if @contract.save
      flash[:success] = ' Created a new contract!'
      @contracts = (can? :manage, Contract) ? (Contract.order :updated_at) : (Contract.current_employee_contracts current_employee)
      case from
      when 'dashboard'
        render "dashboard_create"
      when 'contract'
        render "create"
      else
        render "create"
      end
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

    @contracts = (can? :manage, Contract) ? (Contract.order :updated_at) : (Contract.current_employee_contracts current_employee)

    render 'common_utils/destroy', locals: { table_name: 'list_table' }
  end

  def emp_contracts
    @employee = Employee.where(nickname: params[:nickname].strip).first
    @contracts = Contract.emp_contracts @employee
    render action: 'index'
  end

  private
  def constructed_contract contract_params
    employee_id = contract_params.delete(:employee_id).to_i
    employee = Employee.find employee_id
    contract_params[:employee] = employee
    contract_params
  end
end
