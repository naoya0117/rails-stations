class Admin::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  def index
    @reservations = Reservation.joins(:schedule).where("schedules.end_time > ?", Time.now)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.date = Date.today
    if @reservation.save
      redirect_to admin_reservations_path, notice: 'Reservation was successfully created.'
    else
      flash[:notice] = @reservation.errors.full_messages.join(", ")
      render :new, status: 400
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: 'Reservation was successfully updated.'
    else
      flash[:notice] = @reservation.errors.full_messages.join(", ")
      render :edit, status: 400
    end
  end

  def show
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_url, notice: 'Reservation was successfully destroyed.'
  end


  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email)
  end

end
