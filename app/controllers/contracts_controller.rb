class ContractsController < ApplicationController
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.json
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
  end

  def create
    contract = params[:contract]

    employee_id = contract[:employee_id].to_i
    employee = Employee.where(id: employee_id).first

    start_date = Date.new contract["start_date(1i)"].to_i, contract["start_date(2i)"].to_i, contract["start_date(3i)"].to_i
    end_date = Date.new contract["end_date(1i)"].to_i, contract["end_date(2i)"].to_i, contract["end_date(3i)"].to_i

    salary = contract[:salary].to_f

    @contract = Contract.new(start_date: start_date, end_date: end_date, salary: salary, employee: employee)

    if @contract.save
      redirect_to @contract, notice: 'Contract was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.json
  def update
    @contract = Contract.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end
end
