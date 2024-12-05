class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
    @raclette = @booking.raclette
  end

  def new
    @booking = Booking.new()
    @raclette = Raclette.find(params[:raclette_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @raclette = Raclette.find(params[:raclette_id])
    # ajouter la raclette
    @booking.raclette = @raclette
    # ajouter le statut
    @booking.status = "pending"
    # ajouter le user au booking
    @booking.user = current_user
    @booking.save!
    redirect_to bookings_path
  end

  def my_bookings
  end

  def accept
  end

  def decline
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
