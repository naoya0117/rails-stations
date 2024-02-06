class Admin::SchedulesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def show
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
    params.require(:schedule).permit(:movie_id, :start_time, :end_time)
  end
end
