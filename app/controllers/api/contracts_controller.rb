class Api::ContractsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_contract, only: [:update]

  # GET /contracts
  def index
    @contracts = []
    contracts = Contract.all

    ## Reformat Contracts Data for FE
    contracts.each do |event|
      contract = event.as_json

      ## Reformated data
      contract["tenant_name"] = event.tenant.surname
      contract["phone_number"] = event.tenant.phone_number
      contract["rental_number"] = event.rental.rental_number

      ## Push the formatted contracts to the contracts array
      @contracts.push(contract)
    end

    render json: @contracts
  end

  # GET /contracts/1
  def show
    render json: @contract
  end

  # POST /contracts
  def create

    if Rental.find(contract_params[:rental_id]).status == "Occupied"
      render json: ["Rental not Available."], status: 400
      return
    end
    duration = TimeDifference.between(contract_params[:start_date], contract_params[:end_date]).humanize
    @contract = Contract.new(contract_params.merge(
      duration: duration
    ))

    if @contract.save
      ##Find Rental and change status to Occupied
      @contract.rental.update(status: "Occupied")
      ## Format Contract Data
      contract = @contract.as_json
      contract["tenant_name"] = @contract.tenant.surname
      contract["phone_number"] = @contract.tenant.phone_number
      contract["rental_number"] = @contract.rental.rental_number

      render json: contract, status: :ok
    else
      render json: @contract.errors.messages.first[1], status: 422
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    @contract.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.require(:contract).permit(:start_date, :end_date, :tenant_id, :rental_id)
    end
end
