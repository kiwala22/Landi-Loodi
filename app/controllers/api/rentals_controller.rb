class Api::RentalsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_rental, only: [:update]

  # GET /rentals
  def index
    @rentals = Rental.all

    render json: @rentals
  end

  # POST /rentals
  def create
    @rental = Rental.new(rental_params)

    if @rental.save
      render json: @rental, status: :ok
    else
      render json: {message: @rental.errors.messages.first[1]}, status: 422
    end
  end

  # PATCH/PUT /rentals/1
  def update
    if @rental.update(rental_params)
      render json: @rental, status: :ok
    else
      render json: {message: @rental.errors.messages.first[1]}, status: 422
    end
  end

  # DELETE /rentals/1
  def destroy
    @rental.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_params
      params.require(:rental).permit(:rental_number, :rent_amount, :status)
    end
end
