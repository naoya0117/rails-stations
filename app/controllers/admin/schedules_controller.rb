class Admin::SchedulesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
    @movie = Movie.find_by(params[:movie_id])
  end

  def show
    @movie = @schedule.movie
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path
    else
      render :edit
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to admin_schedules_path
    else
      flash[:notice] = @schedule.errors.full_messages
      render :new, notice: '登録に失敗しました'
    end
  end

  def destroy
    @schedule.destroy
    redirect_to admin_schedules_path
  end

private
# Use callbacks to share common setup or constraints between actions.
  def set_movie
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def schedule_params
    params.require(:schedule).permit(:movie_id, :start_time, :end_time, :screen_id)
  end
end
