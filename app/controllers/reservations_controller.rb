class ReservationsController < ApplicationController
  def new
    unless params[:date] && params[:sheet_id]
      flash[:notice] = "日付または、座席が選択されていません"
      redirect_to movies_path
    end
    @movie = Movie.find_by(params[:movie_id])
    @date = params[:date]
    @schedule = Schedule.find_by(params[:schedule_id])
    @sheet_id = params[:sheet_id]
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if Reservation.exists?(schedule_id: @reservation.schedule_id, sheet_id: @reservation.sheet_id)
      flash[:notice] = "予約済みの座席です"
      redirect_to reservation_movie_path(id: @reservation.schedule.movie_id, schedule_id: @reservation.schedule_id ,date: @reservation.date) and return
    end

    if @reservation.save
      redirect_to movie_path(id: @reservation.schedule.movie_id), notice: "予約が完了しました"
    else
      flash.now[:notice] = "予約に失敗しました"
      render :new
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:schedule_id, :date, :schedule_id, :name, :email, :sheet_id)
  end
end