class Api::PaymentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_payment, only: [:update]

  # GET /payments
  def index
    @payments = []
    payments = Payment.all

    ## Reformat Payments Data for FE
    payments.each do |event|
      payment = event.as_json

      ## Reformated data
      payment["payment_by"] = event.admin.username
      payment["payment_for"] = event.rental.rental_number

      ## Push the formatted payments to the payments array
      @payments.push(payment)
    end

    render json: @payments
  end

  # GET /payments/1
  def show
    render json: @payment
  end

  # POST /payments
  def create
    reference = generate_payment_reference()
    admin = current_admin.id
    @payment = Payment.new(payment_params.merge(
      payment_reference: reference,
      admin_id: admin
      ))

    if @payment.save
      payment = @payment.as_json

      ## Reformat object for FE
      payment["payment_by"] = @payment.admin.username
      payment["payment_for"] = @payment.rental.rental_number

      render json: payment, status: :ok
    else
      render json: @payment.errors.messages.first[1], status: 422
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
  end

    private

    def generate_payment_reference
      begin
        reference = rand(36**8).to_s(36).upcase
      end while Payment.where(payment_reference: reference).exists?
      return "PMT-#{reference}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:amount, :date, :remarks, :rental_id)
    end
end
